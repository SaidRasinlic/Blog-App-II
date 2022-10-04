require 'rails_helper'
require_relative '../features_helper'

describe 'User Show', type: :feature do
  before do
    @name = 'Tom'
    @user = FeaturesHelper.create_and_activate_user(@name)
    FeaturesHelper.create_posts_for_user(@user, count: 4)

    visit new_user_session_path

    fill_in 'Email', with: 'tom@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    mail = FeaturesHelper.find_mail_to 'tom@gmail.com'
    link = mail.body.raw_source.match(/href="(?<url>.+?)">/)[:url]
    visit link

    visit new_user_session_path

    fill_in 'Email', with: 'tom@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    visit user_path(@user)
  end

  it 'shows the profile picture of user' do
    expect(page).to have_css "img[src='#{@name}.jpg']"
  end

  it 'shows username of user' do
    expect(page).to have_content @name
  end

  it 'shows the count of posts by user i.e. 4' do
    expect(page).to have_content 'Number of posts: 4'
  end

  it 'shows the bio of user' do
    expect(page).to have_content "Bio of #{@name}"
  end

  it 'shows a button to show all posts by user' do
    expect(page).to have_button 'See all posts'
  end

  it 'gets redirected to all posts page when user clicks on see all posts button' do
    click_link 'See all posts'

    expect(page).to have_current_path(user_posts_path(@user))
  end
end
