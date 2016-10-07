class CategoriesController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    @categories = Category.search_category(params[:search_category]).recent
      .paginate page: params[:page], per_page: Settings.per_page
    @lesson = Lesson.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.message_success"
    else
      flash[:danger] = t "category.message_failed"
    end
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit :title,
      :quantity_question
  end
end
