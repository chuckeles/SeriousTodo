require "net/http"
require "json"

class TodoAppsController < ApplicationController

  def connect
    redirect_to new_user_session_path unless user_signed_in?

    @todoist_url = "https://todoist.com/oauth/authorize?client_id=#{ Rails.application.secrets.todoist_id }&scope=data:read&state=#{ Rails.application.secrets.state }"
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
      p json_body["access_token"]
      flash[:notice] = "Todoist successfully connected."
    end

    redirect_to todo_apps_connect_path
  end

end
