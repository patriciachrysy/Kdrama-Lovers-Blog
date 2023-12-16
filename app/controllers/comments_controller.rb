class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to user_post_path(@post.author, @post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to user_post_path(@post.author, @post), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
