class Admin::CategoriesController < Admin::BaseController
  before_action :logged_in_user
  before_action :load_category, only: [:destroy, :edit, :update]

  def index
    @categories = Category.search_category(params[:search_category]).recent
      .paginate page: params[:page], per_page: Settings.per_page
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

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "category.message_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "category.message_failed"
      render :edit
    end
  end

  def destroy
    if @category.words.present? && @category.lessons.present?
      flash[:danger] = t "category.destroy_failed"
    else
      if @category.destroy
        flash[:success] = t "category.destroy_message"
      else
        flash[:danger] = t "category.destroy_error"
      end
    end
      redirect_to admin_categories_path
  end

  private
  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "not_found"
      redirect_to admin_categories_path
    end
  end

  def category_params
    params.require(:category).permit :title, :quantity_question
  end
end
