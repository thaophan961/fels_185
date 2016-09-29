class LessonsController < ApplicationController

  def create
    @lesson = current_user.lessons.build lesson_params
    if @lesson.save
      flash[:success] = t "lesson.success_create"
    else
      flash[:danger] = t "lesson.fail_create"
    end
    redirect_to categories_url
  end

  private
  def lesson_params
    params.require(:lesson).permit :category_id,
      results_attributes: [:id, :answer_id, :word_id]
  end
end
