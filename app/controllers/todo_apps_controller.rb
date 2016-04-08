require "net/http"
require "json"
require "aes"

class TodoAppsController < ApplicationController

  before_action :authenticate_user!

  def connect
    if current_user.todo_apps.empty?
      @todoist_url = "https://todoist.com/oauth/authorize?client_id=#{ Rails.application.secrets.todoist_id }&scope=data:read&state=#{ Rails.application.secrets.state }"
      @button_text = "Connect Todoist"
      @button_class = "button"
    else
      @todoist_url = "#"
      @button_text = "Todoist connected"
      @button_class = "button disabled"
    end
  end

  def todoist
    state = params[:state]

    if state != Rails.application.secrets.state
      flash[:danger] = "State does not match! Please try again."
    else
      code = params[:code]

      url = URI("https://todoist.com/oauth/access_token")
      result = Net::HTTP.post_form(url, client_id: Rails.application.secrets.todoist_id, client_secret: Rails.application.secrets.todoist_secret, code: code)

      json_body = JSON.parse(result.body)
      save_token(json_body["access_token"])
      flash[:notice] = "Todoist successfully connected."
    end

    redirect_to todo_apps_connect_path
  end

  private

  def save_token(token)
    current_user.todo_apps.create(token: AES.encrypt(token, Rails.application.secrets.secret_key_base))
  end

end
