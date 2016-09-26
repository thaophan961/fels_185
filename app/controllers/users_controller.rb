class UsersController < ApplicationController

  def show
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "not_found"
      redirect_to root_url
    end
  end

end
