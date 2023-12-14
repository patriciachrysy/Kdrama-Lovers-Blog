class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :posts, foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  before_validation :initialize_posts_counter, on: :create

  mount_uploader :photo, PhotoUploader

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def is?(requested_role)
    role == requested_role.to_s
  end

  private

  def initialize_posts_counter
    self.posts_counter ||= 0
  end
end
