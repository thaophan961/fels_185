class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: [:destroy, :update]

  def show
    @activities = @user.lessons.recent.paginate page: params[:page],
      per_page: Settings.per_page_activities
    @count_following = @user.following.size
    @count_followers = @user.followers.size
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

  def destroy
    if @user.destroy
      flash[:success] = t "admin.destroy_message"
    else
      flash[:danger] = t "admin.message"
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = t "admin.message"
      redirect_to root_url
    end
  end

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "not_found"
      redirect_to root_url
    end
  end
end
