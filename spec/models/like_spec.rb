require 'rails_helper'

RSpec.describe Like, type: :model do
  author = User.create(name: 'John Doe', photo: 'https://jhon-doe-picture', bio: 'This is John Doe bio',
                       posts_counter: 0)

  post = Post.create(author:, title: 'Post title', text: 'Post content', likes_counter: 0, comments_counter: 0)

  subject { Like.new(user: author, post:) }

  describe '#update_post_likes_counter' do
    it 'Should update the likes counter of user upon saving the like' do
      subject.save

      expect(post.likes_counter).to eq(1)
    end
  end
end
