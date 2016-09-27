class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  validates :content, presence: true,
    length: {maximum: Settings.maximum_length_content_word}
  scope :recent, ->{order "created_at DESC"}
end
