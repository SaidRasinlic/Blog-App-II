require 'rails_helper'
require_relative '../features_helper'

feature 'User Index' do
  background do
    @name1 = 'Lilly'
    @user1 = FeaturesHelper.create_and_activate_user(@name1)
    @name2 = 'Tom'
    @user2 = FeaturesHelper.create_and_activate_user(@name2)

    visit users_path
  end

  scenario 'shows username of all the users' do
    expect(page).to have_content @name1
    expect(page).to have_content @name2
  end

  scenario 'shows photos of all the users' do
    expect(page).to have_css "img[src='#{@name1}.jpg']"
    expect(page).to have_css "img[src='#{@name2}.jpg']"
  end

  scenario 'shows zero posts if users have no posts' do
    expect(page).to have_content 'Number of posts: 0'
  end

  scenario 'shows number of posts if users have posts' do
    @user1.posts_counter = 1
    @user2.posts_counter = 5
    [@user1, @user2].each(&:save)

    visit users_path

    expect(page).to have_content 'Number of posts: 1'
    expect(page).to have_content 'Number of posts: 5'
  end

  scenario 'gets redirected to user page after click on it' do
    click_link @name1

    expect(page).to have_current_path(user_path(@user1))
  end
end