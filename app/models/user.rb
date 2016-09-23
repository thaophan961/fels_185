class User < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed, dependent: :destroy
  has_many :followeds, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end
