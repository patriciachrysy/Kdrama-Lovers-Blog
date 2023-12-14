require 'rails_helper'

RSpec.feature 'UserShow', type: :feature do
  include Rails.application.routes.url_helpers

  let(:user) { create(:user, posts_counter: 3) }
  let!(:posts) { create_list(:post, 3, author: user) }

  before do
    visit user_path(user)
  end

  scenario "I can see the user's profile picture" do
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  scenario "I can see the user's username" do
    expect(page).to have_content(user.name)
  end

  scenario "I can see a button that lets me view all of a user's posts" do
    expect(page).to have_link('See all posts', href: user_posts_path(user))
  end

  scenario "When I click a user's post, it redirects me to that post's show page" do
    click_link posts.first.title
    expect(page).to have_current_path(user_post_path(user, posts.first))
  end

  scenario "When I click to see all posts, it redirects me to the user's posts index page" do
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(user))
  end
end
