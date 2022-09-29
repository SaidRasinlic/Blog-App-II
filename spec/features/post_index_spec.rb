require "rails_helper"
require_relative "../features_helper"

RSpec.describe "post/index", type: :feature do
  before(:all) do
    Rails.cache.clear
  end

  before do
    @name = "Tom"
    @user = FeaturesHelper.create_and_activate_user(@name)
    @posts = FeaturesHelper.create_posts_for_user(@user, count: 4)
    @comments = FeaturesHelper.create_comments_for_post_by_user(@posts.last, @user, count: 2)

    visit user_posts_path(@user.id)
  end

  it 'shows the user\'s profile picture' do
    expect(page).to have_css "img[src='#{@name}.jpg']"
  end

  it "shows username" do
    expect(page).to have_content @user.name
  end

  it "shows the number of posts the user has written" do
    expect(page).to have_content "Number of posts: 4"
  end

  it 'shows some of the post\'s body' do
    expect(page).to have_content @posts.last.text
  end

  it "shows the first comments on a post" do
    expect(page).to have_content @comments.first.text
  end

  it "shows how many comments a post has" do
    expect(page).to have_content "Comments: 2"
  end

  it "shows how many likes a post has" do
    expect(page).to have_content "Likes: 0"
  end
end
