require 'rails_helper'

RSpec.describe Comment, type: :model do
  author = User.create(name: 'John Doe', photo: 'https://jhon-doe-picture', bio: 'This is John Doe bio',
                       posts_counter: 0)

  post = Post.create(author:, title: 'Post title', text: 'Post content', likes_counter: 0, comments_counter: 0)

  subject { Comment.new(user: author, post:, text: 'Comment content') }

  describe '#update_post_comments_counter' do
    it 'Should update the comments counter of user upon saving the comment' do
      subject.save

      expect(post.comments_counter).to eq(1)
    end
  end
end
