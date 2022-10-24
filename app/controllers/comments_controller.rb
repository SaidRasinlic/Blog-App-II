class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    post = Post.find(params[:post_id])
    render json: post.comments
  end

  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    comment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { comment: } }
    end
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    comment = Comment.new(comment_params)
    comment.author_id = @user.id
    comment.post_id = @post.id
    respond_to do |format|
      format.html do
        if comment.save
          flash[:success] = 'Comment saved successfully'
          redirect_to user_post_path(@user, @post)
        else
          flash.now[:error] = 'Error: Comment could not be saved'
          render :new, locals: { comment: }
        end
      end
    end
  end

  def destroy
    @comment = Comment.includes(:author, :post).find(params[:id])
    user = @comment.author
    post = @comment.post

    if @comment.destroy
      flash[:success] = 'Comment deleted successfully'
    else
      flash.now[:error] = 'Error: Comment could not be deleted'
    end
    redirect_to user_post_path(user, post)
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
