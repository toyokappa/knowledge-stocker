class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      create_session(user)
      redirect_to user
    else
      flash.now[:danger] = t(:authentication_failed, scope: :flash)
      render "new"
    end
  end

  def destroy
    destroy_session
    redirect_to root_path
  end

  private

  def destroy_session
    session.delete(:user_id)
  end
end
