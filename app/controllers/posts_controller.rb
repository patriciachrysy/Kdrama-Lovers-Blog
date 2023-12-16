class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @author = current_user
    @post = @author.posts.new(post_params)
    @post.likes_counter = 0
    @post.comments_counter = 0

    if @post.save
      redirect_to user_post_path(@author, @post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @author = current_user
    @post = @author.posts.find(params[:id])
    @post.destroy

    redirect_to user_posts_path(@author), status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
