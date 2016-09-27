class WordsController < ApplicationController
  def index
    @words = Word.includes(:answers).recent.paginate page: params[:page],
      per_page: Settings.per_page_words
  end
end
