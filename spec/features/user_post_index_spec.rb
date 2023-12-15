require 'rails_helper'

RSpec.feature 'UserPostIndex', type: :feature do
  let(:user) { create(:user) }
  let!(:post) { create(:post, author: user) }
  let!(:comment) { create(:comment, post:, user:) }

  before do
    visit user_posts_path(user)
  end

  scenario "I can see the user's profile picture" do
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  scenario "I can see the user's username" do
    expect(page).to have_content(user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    expect(page).to have_content(user.posts_counter)
  end

  scenario "I can see a post's title" do
    expect(page).to have_content(post.title)
  end

  scenario "I can see some of the post's body" do
    expect(page).to have_content(post.text.truncate(100))
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view' do
    expect(page).to have_selector('.pagination')
  end

  scenario "When I click on a post, it redirects me to that post's show page" do
    click_link post.title
    expect(page).to have_current_path(user_post_path(user, post))
  end
end
