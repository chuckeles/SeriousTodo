class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user and user.authenticate(params[:session][:password])
      login(user)
      redirect_to user
    else
      flash.now[:danger] = "Invalid email and password combination"
      render :new
    end
  end

  def destroy
  end

end
