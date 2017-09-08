class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user
  helper_method :current_user, :logged_in?
  add_flash_types :success, :danger

  private

    def authenticate_user
      unless logged_in?
        redirect_to login_url, danger: t(:authentication_alert, scope: :flash)
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
