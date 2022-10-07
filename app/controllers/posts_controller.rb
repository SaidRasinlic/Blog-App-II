class PostsController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @all_posts = @user.posts.includes(comments: [:author]).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.includes(comments: [:author]).find(params[:id])
  end

  def new
    @user = current_user
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: } }
    end
  end

  def create
    @user = current_user
    post = Post.new(params.require(:post).permit(:text, :title))
    post.author_id = @user.id
    respond_to do |format|
      format.html do
        if post.save
          flash[:success] = 'Post saved successfully'
          redirect_to user_posts_path(@user)
        else
          flash.now[:error] = 'Error: Post could not be saved'
          render :new, locals: { post: }
        end
      end
    end
  end

  def destroy
    @user = current_user
    post = Post.find(params[:id])

    if post.destroy
      flash[:success] = 'Post deleted successfully'
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'Error: Post could not be deleted'
      redirect_to user_post_path(@user, post)
    end
  end
end
