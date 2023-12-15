class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :update_post_comments_counter
  after_destroy :update_post_comments_counter

  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end

  def truncated_comment
    return text unless text.length > 65

    "#{text[0...65]}..."
  end
end
