class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_home_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def home
    @user = current_user

    @greeting = %w[ broseph broham brohamulus broski broseidon broidi ].sample
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
