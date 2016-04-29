require "net/http"
require "json"
require "aes"
require_relative "../utilities/todoist"

class TasksController < ApplicationController

  before_action :authenticate_user!
  before_action do
    if not Todoist.connected?(current_user)
      flash[:alert] = "You have to connect a to-do app first."
      redirect_to todo_apps_connect_path
    end
  end

  def index
    @items = Todoist.items(current_user, flash)

    if not @items
      redirect_to todo_apps_connect_path
    end
  end

  def show
    @item = Todoist.item(params[:id].to_i, current_user, flash)

    redirect_to tasks_path unless @item
  end

end
