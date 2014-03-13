class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Exception, with: :rescued unless Rails.env.development?
  before_filter :check_session

  def check_session
    user = User.find(session[:user])
    if user.token == session[:token]
      @current_user = user
    else
      @current_user = nil
    end
  rescue ActiveRecord::RecordNotFound
    @current_user = nil
  end

  def rescued(exception)
    redirect_to root_path, alert: "Invalid url"
  end
end
