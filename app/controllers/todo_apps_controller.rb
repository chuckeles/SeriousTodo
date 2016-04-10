require "net/http"
require "json"
require "aes"
require_relative "../integrations/todoist"

class TodoAppsController < ApplicationController

  before_action :authenticate_user!

  def connect
    if Todoist.connected?(current_user)
      @todoist_url = ""
      @button_text = "Todoist connected"
      @button_class = "button disabled"
    else
      @todoist_url = Todoist.authorize_url
      @button_text = "Connect Todoist"
      @button_class = "button"
    end
  end

  def todoist
    state = params[:state]
    code = params[:code]

    Todoist.authorize(current_user, state, code, flash)
    redirect_to todo_apps_connect_path
  end

end
