class TasksController < ApplicationController

  before_action :authenticate_user!
  before_action do
    if current_user.todo_apps.empty?
      flash[:alert] = "You have to connect a todo app first."
      redirect_to todo_apps_connect_path
    end
  end

  def index

  end

end
