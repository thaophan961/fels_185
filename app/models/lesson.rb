class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :answers, through: :results
  has_many :words, through: :results
  accepts_nested_attributes_for :results
  before_create :build_results
  delegate :title, to: :category, allow_nil: true

  private
  def build_results
    self.category.words.random.limit(category.quantity_question).each do |word|
      self.results.build word_id: word.id
    end
  end
end
