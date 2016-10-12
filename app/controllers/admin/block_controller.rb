class Admin::BlockController < Admin::BaseController
  before_action :logged_in_user
  before_action :load_category, only: :update

  def update
    if @category.update_attributes is_block: params[:is_block]
      flash[:success] = t "category.message_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "category.message_failed"
      redirect_to admin_categories_path
    end
  end

  private
  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "not_found"
      redirect_to admin_categories_path
    end
  end
end
