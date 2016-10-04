class User < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed, dependent: :destroy
  has_many :followeds, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  has_secure_password
  scope :alphabet, ->{order :name}

  before_save :downcase_email

  def forget
    update_attributes(remember_digest: nil)
  end

  def feed_activities
    Lesson.feed_activities id
  end

  private
  def downcase_email
    self.email = email.downcase
  end
end
