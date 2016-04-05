class TodoAppsController < ApplicationController

  def connect
    redirect_to new_user_session_path unless user_signed_in?

    @todoist_url = "https://todoist.com/oauth/authorize?client_id=3730f95dc06d48608155f8fb37484ba1&scope=data:read&state=" + Rails.application.secrets.state
  end

  def todoist
    flash[:notice] = "Todoist successfully connected."

    redirect_to todo_apps_connect_path
  end

end
