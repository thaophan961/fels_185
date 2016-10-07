class Admin::WordsController < ApplicationController
  def index
    @words = Word.includes(:answers).filter_category(params[:category_id])
      .paginate page: params[:page], per_page: Settings.per_page_words
  end
end
