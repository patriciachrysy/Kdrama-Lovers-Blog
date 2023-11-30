require 'rails_helper'
require 'securerandom'

RSpec.describe Post, type: :model do
  author = User.create(name: 'John Doe', photo: 'https://jhon-doe-picture', bio: 'This is John Doe bio',
                       posts_counter: 0)

  subject { Post.new(author:, title: 'Post title', text: 'Post content', likes_counter: 0, comments_counter: 0) }

  describe '#validators' do
    before { subject.save }

    it 'Title should be present' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'Title should not be too long' do
      subject.title = SecureRandom.hex(150)

      expect(subject).to_not be_valid
    end

    it 'CommentsCounter and likesCounter should be greater of equal to 0' do
      expect(subject).to be_valid
    end
  end

  describe '#recent_comments' do
    it 'Should return an empty array for the most recent comments if there are no comments' do
      subject.save
      expect(subject.recent_comments.length).to eq(0)
    end

    it 'should return the 5 latest posts of the user' do
      subject.save

      first_comment = Comment.create(user: author, post: subject, text: 'First comment')
      second_comment = Comment.create(user: author, post: subject, text: 'Second comment')
      third_comment = Comment.create(user: author, post: subject, text: 'Third comment')
      fourth_comment = Comment.create(user: author, post: subject, text: 'Fourth comment')
      fifth_comment = Comment.create(user: author, post: subject, text: 'Fifth comment')
      sixth_comment = Comment.create(user: author, post: subject, text: 'Sixth comment')

      expect(subject.recent_comments.length).to eq(5)
      expect(subject.recent_comments).to include(fifth_comment)
      expect(subject.recent_comments).to include(second_comment)
      expect(subject.recent_comments).to include(third_comment)
      expect(subject.recent_comments).to include(fourth_comment)
      expect(subject.recent_comments).to include(sixth_comment)
      expect(subject.recent_comments).to_not include(first_comment)
    end

    it 'Should update the posts conter of user upon saving the post' do
      subject.save

      expect(author.posts_counter).to eq(1)
    end
  end
end
