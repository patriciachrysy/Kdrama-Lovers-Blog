class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :update_post_comments_counter

  def truncated_comment
    return text unless text.length > 65

    "#{text[0...65]}..."
  end

  private

  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
