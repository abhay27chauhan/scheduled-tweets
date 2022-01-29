class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user

  def set_current_user
    if session[:user_id]
      @user_current = User.find_by(id: session[:user_id])
    end
  end

  def require_user_logged_in!
    redirect_to sign_in_path, alert: "You must be signed in to do that" if @user_current.nil?
  end
end

# find will give error if user does not exists but find_by don't