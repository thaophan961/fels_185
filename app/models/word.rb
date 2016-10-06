class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  validates :content, presence: true,
    length: {maximum: Settings.maximum_length_content_word}
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
      (SELECT lesson_id FROM lessons WHERE user_id = ?))", user_id
  end
  scope :not_learned, ->user_id do
    where "id NOT IN (SELECT word_id FROM results WHERE lesson_id IN
      (SELECT lesson_id FROM lessons WHERE user_id = ?))", user_id
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
end
