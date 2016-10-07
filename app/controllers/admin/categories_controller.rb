class Admin::CategoriesController < Admin::BaseController
  before_action :logged_in_user, only: [:index, :new, :create]

  def index
    @categories = Category.recent.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.message_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :title, :quantity_question
  end
end
