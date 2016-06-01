require "stripe"

class UsersController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    @user = User.find_by_name(params[:name])
  end

  def show_credit_card
    authenticate_user!
  end

  def create_credit_card
    authenticate_user!
    token = params[:token]

    customer = Stripe::Customer.create(email: current_user.email, source: token)
    current_user.update_attribute(:customer_id, customer.id)

    flash[:notice] = "Successfully added the credit card."
    redirect_to users_credit_card_path

    Analytics.track(
      user_id: current_user.id,
      event: "Added Credit Card"
    )
  end

  def delete_credit_card
    authenticate_user!

    # TODO: Remove Stripe customer
    current_user.update_attribute(:customer_id, nil)

    flash[:notice] = "Deleted the credit card."
    redirect_to users_credit_card_path

    Analytics.track(
      user_id: current_user.id,
      event: "Deleted Credit Card"
    )
  end

end
