class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t(:registration_success, scope: :flash)
      create_session(@user)
      redirect_to user_path
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
      flash[:success] = t(:update_success, scope: :flash)
      redirect_to user_path
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
