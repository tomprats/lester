class UsersController < ApplicationController
  before_filter :current_user, except: [:logout]

  def profile
  end

  def login
  end

  def signup
    if params[:user][:password] != params[:user][:password_confirmation]
      redirect_to login_path, alert: "Passwords don't match"
    else
      user = User.new(user_params)
      user.password = params[:user][:password]
      if user.save!
        session[:user]  = user.id
        session[:token] = user.token

        redirect_to root_path, notice: "Welcome to the world of art"
      else
        redirect_to login_path, alert: "Unable to sign up"
      end
    end
  end

  def signin
    user = User.where(email: params[:user][:email]).first
    if user.password == params[:user][:password]
      session[:user]  = user.id
      session[:token] = user.token

      redirect_to root_path, notice: "Welcome to the world of art"
    else
      redirect_to login_path, alert: "Unable to sign in"
    end
  end

  def logout
    User.find(session[:user]).update_attribute(:token, SecureRandom.uuid)
  ensure
    session[:user] = nil
    session[:token] = nil
    redirect_to login_path
  end

  private
  def current_user
    redirect_to root_path, notice: "You're already logged in!" if @current_user
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end
