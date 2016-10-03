class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :answer
  belongs_to :word
  delegate :content, to: :word, prefix: :word, allow_nil: true
end
