class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = User.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = User.posts.find(params[:id])
  end
end
