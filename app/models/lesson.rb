class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :answers, through: :results
  has_many :words, through: :results
  accepts_nested_attributes_for :results
  before_create :build_results
  delegate :title, to: :category, allow_nil: true
  scope :recent, ->{order "created_at DESC"}
  scope :feed_activities, ->user_id do
    where "user_id IN (SELECT followed FROM relationships WHERE follower = ?)
      OR user_id = ?", user_id, user_id
  end

  def score
    answers.correct.size
  end

  private
  def build_results
    self.category.words.random.limit(category.quantity_question).each do |word|
      self.results.build word_id: word.id
    end
  end
end
