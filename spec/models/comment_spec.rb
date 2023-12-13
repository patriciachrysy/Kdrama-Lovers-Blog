require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:author) { User.create(name: 'John Doe', photo: 'https://jhon-doe-picture', bio: 'This is John Doe bio', posts_counter: 0) }
  let(:post) do
    Post.create(author:, title: 'Post title', text: 'Post content', likes_counter: 0, comments_counter: 0)
  end
  let(:comment) { Comment.new(user: author, post:, text: 'Comment content') }

  before do
    3.times do
      author.posts.create(title: 'Post title', text: 'Post content')
    end
  end

  describe '#update_post_comments_counter' do
    it 'Should update the comments counter of user upon saving the comment' do
      comment.save
      post.reload

      expect(post.comments_counter).to eq(1)
    end
  end
end
