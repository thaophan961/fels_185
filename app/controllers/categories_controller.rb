class CategoriesController < ApplicationController
  def index
    @categories = Category.recent.paginate page: params[:page],
      per_page: Settings.per_page
  end
end
