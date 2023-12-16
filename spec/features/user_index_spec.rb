require 'rails_helper'

RSpec.feature 'UserIndex', type: :feature do
  let!(:user1) { create(:user, posts_counter: 5) }
  let!(:user2) { create(:user, posts_counter: 3) }

  before do
    visit users_path
  end

  scenario 'I can see the name of all other users' do
    expect(page).to have_content(user1.name)
    expect(page).to have_content(user2.name)
  end

  scenario 'I can see the profile picture for each user' do
    expect(page).to have_css("img[src*='#{user1.photo}']")
    expect(page).to have_css("img[src*='#{user2.photo}']")
  end

  scenario 'I can see the number of posts each user has written' do
    expect(page).to have_content(user1.posts_counter)
    expect(page).to have_content(user2.posts_counter)
  end

  scenario "When I click on a user, I am redirected to that user's show page" do
    click_link "#{user1.name} #{user1.id}"
    expect(page).to have_current_path(user_path(user1))
  end
end
