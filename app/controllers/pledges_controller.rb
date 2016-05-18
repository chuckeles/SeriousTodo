class PledgesController < ApplicationController

  def create
    pledge = Pledge.new(task_id: params[:id], amount: params[:amount])
    if (pledge.save)
      flash[:notice] = "Successfully pledged on the task."
      redirect_to tasks_path
    else
      flash[:danger] = pledge.errors.full_messages.first
      redirect_to task_path(params[:id])
    end
  end

end
