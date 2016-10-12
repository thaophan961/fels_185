class Admin::WordsController < Admin::BaseController
  before_action :load_word, except: [:index, :new, :create]
  before_action :load_category, except: [:show, :new]
  before_action :verify_category_is_block, except: :index

  def index
    @words = @category.words.includes(:answers)
      .search_by_condition(params[:search_word]).recent
      .paginate page: params[:page], per_page: Settings.per_page_words
  end

  def new
    @word = Word.new
    @word.answers.new
  end

  def create
    @word = @category.words.new word_params
    if @word.save
      flash[:success] = t "admin.word.create_success"
      redirect_to admin_category_words_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "admin.word.update_success"
      redirect_to admin_category_words_path
    else
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t "word.delete_success_message"
    else
      flash[:danger] = t "word.delete_fail_message"
    end
    redirect_to admin_category_words_path
  end

  private
  def load_word
    @word = Word.find_by id: params[:id]
    unless @word
      flash[:danger] = t "word.not_found"
      redirect_to admin_categories_path
    end
  end

  def load_category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = t "admin.word.category_not_found"
      redirect_to admin_categories_path
    end
  end

  def word_params
    params.require(:word).permit :content,
      answers_attributes: [:id, :content, :is_correct]
  end

  def verify_category_is_block
    load_category
    if @category.is_block?
      flash[:danger] = t "category.message_error"
      redirect_to admin_category_words_path @category
    end
  end
end
