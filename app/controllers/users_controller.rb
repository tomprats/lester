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
      # TODO this merge hash could be removed by using default database attributes and before callbacks on the
      # model
      user = User.new(params[:user].merge!({ artist: false, :admin: false, token: SecureRandom.uuid }))
      user.password = params[:user][:password]
      if user.save!
        session[:user]  = user.id
        session[:token] = user.token

        redirect_to root_path, notice: "Welcome to Code Calmly"
      else
        # TODO you may want this to be a bit nicer :)
        redirect_to login_path, alert: "Unable to sign up"
      end
    end
  end

  def signin
    user = User.where(email: params[:user][:email]).first
    if user.password == params[:user][:password]
      user.update_attribute(:token, SecureRandom.uuid)
      session[:user]  = user.id
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

  def user
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
