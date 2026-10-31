class SessionsController < ApplicationController
  def new
    # user is already logged in
    redirect_to user_home_path if current_user
  end

  def create
    user = User.find_by email: params[:email]

    if user&.authenticate params[:password]
      session[:user_id] = user.id
      redirect_to user_home_path
    else
      flash[:error] = "Invalid email or password."
      redirect_to "/session/new"
    end
  end

  def destroy
    reset_session and redirect_to root_path
  end
end
