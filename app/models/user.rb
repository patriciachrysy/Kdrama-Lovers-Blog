class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  validates :name, presence: true

  def posts_counter
    posts.count
  end

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
