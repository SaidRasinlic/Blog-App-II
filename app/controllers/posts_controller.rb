class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @all_posts = @user.posts.includes(:comments).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end
end
