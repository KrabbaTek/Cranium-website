class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:email]

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_home_path
    else
      flash[:error] = "Invalid email or password."
      redirect_to login_path
    end
  end

  def destroy
  end
end
