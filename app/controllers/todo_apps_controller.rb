require "net/http"
require "json"
require "aes"
require_relative "../utilities/todoist"

class TodoAppsController < ApplicationController

  before_action :authenticate_user!

  def connect
    if Todoist.connected?(current_user)
      @todoist_url = ""
      @button_text = "<i class='fa fa-check'></i> Todoist connected"
      @button_class = "button disabled"
    else
      @todoist_url = Todoist.authorize_url
      @button_text = "<i class='fa fa-plug'></i> Connect Todoist"
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
