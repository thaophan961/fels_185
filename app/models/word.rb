class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers
  validates :content, presence: true,
    length: {maximum: Settings.maximum_length_content_word}
  validate :answers_quantity
  scope :recent, ->{order "created_at DESC"}
  scope :random, ->{order "RANDOM()"}
  scope :search_by_condition, ->condition do
    where "content LIKE ?", "%#{condition}%" if condition.present?
  end
  scope :filter_category, ->category_id do
    where category_id: category_id if category_id.present?
  end
  scope :learned, ->user_id do
    where "id IN (SELECT word_id FROM results WHERE lesson_id IN
      (SELECT id FROM lessons WHERE user_id = ?))", user_id
  end
  scope :not_learned, ->user_id do
    where "id NOT IN (SELECT word_id FROM results WHERE lesson_id IN
      (SELECT id FROM lessons WHERE user_id = ?))", user_id
  end
  scope :learned_correct, ->user_id do
    where "id IN ( SELECT r.word_id FROM results r INNER JOIN answers a
      ON r.answer_id = a.id WHERE lesson_id IN (SELECT id FROM lessons
        WHERE user_id = ?) and a.is_correct = ?)", user_id, true
  end
  scope :learned_not_correct, ->user_id do
    where "id IN ( SELECT r.word_id FROM results r INNER JOIN answers a
      ON r.answer_id = a.id WHERE lesson_id IN (SELECT id FROM lessons
        WHERE user_id = ?) and a.is_correct = ?)", user_id, false
  end

  class << self
    def to_csv
      CSV.generate do |csv|
        csv << [I18n.t("word.word"), I18n.t("word.mean")]
        all.each do |word|
          word.answers.each do |answer|
            csv << [word.content, answer.content] if answer.is_correct
          end
        end
      end
    end
  end

  private
  def answers_quantity
    errors.add :answers, I18n.t("word.answer_quanlity_error") if
      answers.size < Settings.answer_quanlity
    errors.add :answers, I18n.t("word.must_has_correct_answer_error") if
      answers.reject{|answer| !answer.is_correct?}.count == 0
  end
end
