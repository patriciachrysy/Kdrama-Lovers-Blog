class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new
    @like.user = current_user
    @like.save
    redirect_to user_post_path(@post.author, @post)
  end
end
