require "net/http"
require "json"
require "aes"

class TasksController < ApplicationController

  @@todoist_url = URI("https://todoist.com/API/v6/sync")

  before_action :authenticate_user!
  before_action do
    if current_user.todo_apps.empty?
      flash[:alert] = "You have to connect a todo app first."
      redirect_to todo_apps_connect_path
    else
      @app = current_user.todo_apps.first
    end
  end

  def index
    token = AES.decrypt(@app.token, Rails.application.secrets.secret_key_base)
    result = Net::HTTP.post_form(@@todoist_url, token: token, seq_no: 0, resource_types: '["items"]')
    json_body = JSON.parse(result.body)

    if json_body["error"] and json_body["error"] == "Invalid token"
      @app.destroy
      flash[:danger] = "Invalid token! Please connect the todo app again."
      redirect_to todo_apps_connect_path
      return
    end

    @items = json_body["Items"].map do |item|
      {
        id: item["id"],
        content: item["content"]
      }
    end
    @items.sort! do |a, b|
      a[:content] <=> b[:content]
    end
  end

end
