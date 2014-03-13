class UsersController < ApplicationController
  require "bcrypt"

  before_filter :current_user, except: [:logout]

  def profile
  end

  def login
  end

  def signup
    # Email present
    if params[:user][:email].blank?
      redirect_to login_path, alert: "Email is required"
    # Unique email
    elsif !User.where(email: params[:user][:email]).empty?
      redirect_to login_path, alert: "Email already taken"
    # Password present
    elsif params[:user][:password].blank?
      redirect_to login_path, alert: "Password is required"
    # Matching passwords
    elsif params[:user][:password] != params[:user][:password_confirmation]
      redirect_to login_path, alert: "Passwords don't match"
    else
      user = User.create(
        first_name:         params[:user][:first_name],
        last_name:          params[:user][:last_name],
        email:              params[:user][:email],
        encrypted_password: password,
        artist:             false,
        admin:              false,
        token:              SecureRandom.uuid
      )

      session[:user] = user.id
      session[:token] = user.token

      redirect_to root_path, notice: "Welcome to Code Calmly"
    end
  end

  def signin
    user = User.where(email: params[:user][:email]).first
    if user && BCrypt::Password.new(user.encrypted_password) == params[:user][:password]
      user.update_attribute(:token, SecureRandom.uuid)
      session[:user] = user.id
      session[:token] = user.token
      redirect_to root_path, notice: "Welcome to Code Calmly"
    else
      redirect_to login_path, alert: "Invalid credentials"
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

  def password
    BCrypt::Password.create(params[:user][:password])
  end
end
