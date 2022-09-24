class CommentsController < ApplicationController
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
    comment = Comment.new(params.require(:comment).permit(:text))
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
end
