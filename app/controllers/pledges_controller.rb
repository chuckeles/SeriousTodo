class PledgesController < ApplicationController

  before_action :authenticate_user!

  def create
    pledge = current_user.pledges.new(task_id: params[:id], amount: params[:amount])
    if (pledge.save)
      flash[:notice] = "Successfully pledged on the task."
      redirect_to tasks_path

      Analytics.track(
        user_id: current_user.id,
        event: "Pledged",
        properties: {
          amount: pledge.amount
        }
      )
    else
      flash[:danger] = pledge.errors.full_messages.first
      redirect_to task_path(params[:id])
    end
  end

end
