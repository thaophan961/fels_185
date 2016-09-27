class Category < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :words, dependent: :destroy
  validates :title, presence: true,
    length: {maximum: Settings.maximum_length_title_category}
  validates :quantity_question, presence: true
  scope :recent, ->{order "created_at DESC"}
  scope :search_category, ->condition do
    where "title LIKE ?", "%#{condition}%" if condition.present?
  end
end
