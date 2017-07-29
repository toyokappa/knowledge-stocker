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
      flash.now[:danger] = "メールアドレスもしくはパスワードが間違っています。"
      render "new"
    end
  end

  def destroy
    destroy_session
    redirect_to root_path
  end

  private

  def create_session(user)
    session[:user_id] = user.id
  end

  def destroy_session
    session.delete(:user_id)
    @current_user = nil
  end
end
