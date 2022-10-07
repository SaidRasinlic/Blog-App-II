class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id] || params[:id])
    like = Like.new
    like.post_id = @post.id
    like.author_id = @user.id

    if like.save
      flash[:success] = "Like saved successfully"
    else
      flash[:error] = "Error: Like could not be saved"
    end
    redirect_to user_post_path(@user, @post)
  end
end
