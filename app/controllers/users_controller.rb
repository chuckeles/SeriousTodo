class UsersController < ApplicationController

  def show
    @user = User.find_by_name(params[:name])
  end

  def show_credit_card
  end

  def create_credit_card
    redirect_to users_credit_card_path
  end

end
