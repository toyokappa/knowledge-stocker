class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      create_session(@user)
      redirect_to user_path, success: t(:registration_success, scope: :flash)
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
      redirect_to user_path, success: t(:update_success, scope: :flash)
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
