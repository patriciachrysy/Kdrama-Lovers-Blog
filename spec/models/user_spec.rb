require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe', photo: 'https://jhon-doe-picture', bio: 'This is John Doe bio', posts_counter: 0) }

  before { subject.save }

  describe '#validators' do
    it 'Name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'PostsCounter should be greater of equal to 0' do
      subject.posts_counter = 0
      expect(subject).to be_valid
    end
  end

  describe '#recent_posts' do
    it 'Should return an empty array for the most recent posts if the user has no post' do
      expect(subject.recent_posts.length).to eq(0)
    end

    it 'should return the 3 latest posts of the user' do
      first_post = subject.posts.new(title: 'First post', text: 'Post content', likes_counter: 0, comments_counter: 0)
      second_post = subject.posts.new(title: 'Second post', text: 'Post content', likes_counter: 0,
                                      comments_counter: 0)
      third_post = subject.posts.new(title: 'Third post', text: 'Post content', likes_counter: 0, comments_counter: 0)
      fourth_post = subject.posts.new(title: 'Fourth post', text: 'Post content', likes_counter: 0,
                                      comments_counter: 0)

      first_post.save
      second_post.save
      third_post.save
      fourth_post.save

      expect(subject.recent_posts).to include(fourth_post)
      expect(subject.recent_posts).to include(third_post)
      expect(subject.recent_posts).to include(second_post)
      expect(subject.recent_posts).to_not include(first_post)
    end
  end
end