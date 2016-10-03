class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :load_lesson, only: [:edit, :update, :show]

  def show
    @results = @lesson.results
  end

  def edit
    @words = @lesson.words
  end

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = t "lesson.finish_message"
      redirect_to lesson_path @lesson
    else
      render :edit
    end
  end

  def create
    @lesson = current_user.lessons.build lesson_params
    if @lesson.save
      flash[:success] = t "lesson.success_create_message"
      redirect_to edit_lesson_path @lesson
    else
      flash[:danger] = t "lesson.fail_create_message"
      redirect_to categories_path
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :category_id, :result,
      results_attributes: [:id, :answer_id, :word_id]
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    unless @lesson
      flash[:danger] = t "lesson.not_found"
      redirect_to categories_path
    end
  end
end
