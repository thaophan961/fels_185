class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]

  def show
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "not_found"
      redirect_to root_url
    end
  end

end
