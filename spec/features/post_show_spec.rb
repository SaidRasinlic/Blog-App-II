require "rails_helper"
require_relative "../features_helper"

RSpec.describe "post/show" do
  before(:all) do
    Rails.cache.clear
  end

  before do
    @name = "Tom"
    @user = FeaturesHelper.create_and_activate_user(@name)
    @post = FeaturesHelper.create_posts_for_user(@user).first
    @comments = FeaturesHelper.create_comments_for_post_by_user(@post, @user, count: 2)

    visit user_post_path(@user, @post)
  end

  it "shows username" do
    expect(page).to have_content @user.name
  end

  it 'shows some of the post\'s body' do
    expect(page).to have_content @post.text
  end

  it "shows all comments on the post" do
    @comments.each { |comment| expect(page).to have_content comment.text }
  end

  it "shows username of the commenter" do
    @comments.each { |comment| expect(page).to have_content comment.author.name }
  end

  it "shows how many comments the post has" do
    expect(page).to have_content "Comments: 2"
  end

  it "shows how many likes the post has" do
    expect(page).to have_content "Likes: 0"
  end

  it "click on user's post should redirect to that posts show page" do
    visit user_posts_path(@user.id)
    click_link "post-tile-btn"
    expect(current_path).to eq user_post_path(@user, @post)
  end
end
