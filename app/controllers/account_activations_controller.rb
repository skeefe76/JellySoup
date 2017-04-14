class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated,    true)
      user.update_attribute(:activated_at, Time.zone.now)
      session[:user_id] = user.id
      # redirect_to @user, notice: "Thanks for signing up!"
      flash[:notice] = "Account activated!"
      redirect_to user
    else
      flash[:alert] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
