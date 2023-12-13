require 'rails_helper'

RSpec.feature 'PostShow', type: :feature do
  let(:user) { create(:user) }
  let(:post) { create(:post, author: user) }
  let!(:comment) { create(:comment, post:, user:) }

  before do
    visit user_post_path(user, post)
  end

  it "displays the post's title" do
    expect(page).to have_content(post.title)
  end

  it "displays the post's author" do
    expect(page).to have_content(post.author.name)
  end

  it 'displays the number of comments' do
    expect(page).to have_content(post.comments.count)
  end

  it 'displays the number of likes' do
    expect(page).to have_content(post.likes.count)
  end

  it 'displays the post body' do
    expect(page).to have_content(post.text)
  end

  it 'displays the username of each commentor' do
    expect(page).to have_content(comment.user.name)
  end

  it 'displays the comment each commentor left' do
    expect(page).to have_content(comment.text)
  end
end
