class  Admin::UsersController < Admin::BaseController
  before_action :load_user, :check_current_admin, only: [:edit, :update,
    :destroy]

  def index
    @users = User.alphabet.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "admin.result.success"
      redirect_to admin_users_path
    else
      flash[:danger] = t "admin.result.failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.destroy_message"
    else
      flash[:danger] = t "admin.message"
    end
    redirect_to admin_users_path
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
    params.require(:user).permit :is_admin
  end
end
