class Admin::BaseController < ApplicationController
  before_action :verify_admin
  include SessionsHelper

  private
  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = t "admin.message"
      redirect_to root_url
    end
  end

  def check_current_admin
    @user = User.find_by id: params[:id]
    if current_user? @user || @user.nil?
      flash[:danger] = t "admin.check_current_admin_message"
      redirect_to admin_root_path
    end
  end
end
