class TodoAppsController < ApplicationController

  def connect
    redirect_to new_user_session_path unless user_signed_in?
  end

end
