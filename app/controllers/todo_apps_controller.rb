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

  def connect_todoist
    state = params[:state]
    code = params[:code]

    Todoist.authorize(current_user, state, code, flash)
    redirect_to todo_apps_connect_path
  end

  def disconnect
    if Todoist.connected?(current_user)
      @button_url = todo_apps_disconnect_todoist_path
      @button_text = "<i class='fa fa-trash'></i> Disconnect Todoist"
      @button_class = "button"
    else
      @button_url = ""
      @button_text = "<i class='fa fa-ban'></i> Todoist not connected"
      @button_class = "button disabled"
    end
  end

  def disconnect_todoist
    TodoApp.delete_all
    flash[:notice] = "Todoist disconnected."

    redirect_to todo_apps_connect_path
  end

end
