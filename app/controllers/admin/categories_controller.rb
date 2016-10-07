class Admin::CategoriesController < ApplicationController

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
