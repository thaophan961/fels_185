class Answer < ActiveRecord::Base
  belongs_to :word
  has_many :results, dependent: :destroy
  scope :alphabel, ->{order "content"}
  scope :correct, ->{where is_correct: true}
  validates :content, presence: true
end
