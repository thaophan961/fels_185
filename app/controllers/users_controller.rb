class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update.message"
      redirect_to @user
    else
      render :edit
    end
  end

  def index
    @users = User.alphabet.paginate page: params[:page],
      per_page: Settings.per_page
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "not_found"
      redirect_to root_url
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

end
