class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user
  helper_method :current_user, :logged_in?

  private

  def authenticate_user
    unless logged_in?
      flash[:danger] = t(:authentication_alert, scope: :flash)
      redirect_to login_url
    end
  end

  def create_session(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end
end
