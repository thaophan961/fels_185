class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless current_user? @user
  end

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "please_login"
      redirect_to sign_in_path
    end
  end
end
