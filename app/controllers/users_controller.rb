class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t(:registration_success)
      log_in(@user)
      redirect_to @user
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:success] = t(:update_success)
      redirect_to current_user
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
