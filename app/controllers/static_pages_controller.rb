class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = current_user.feed_activities.recent
        .paginate page: params[:page], per_page: Settings.per_page_activities
      @words = Word.includes(:answers).learned current_user.id
    end
  end
end
