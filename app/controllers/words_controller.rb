class WordsController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    @categories = Category.all
    @words = if params[:condition] && params[:condition] == t("get_all")
      Word.includes(:answers).filter_category(params[:category_id])
    elsif params[:condition]
      Word.includes(:answers).filter_category(params[:category_id])
        .send(params[:condition], current_user.id)
    else
      Word.includes(:answers).search_by_condition params[:search_word]
    end.recent.paginate page: params[:page], per_page: Settings.per_page_words
  end
end
