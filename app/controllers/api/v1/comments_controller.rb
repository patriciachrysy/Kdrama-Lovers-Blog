class Api::V1::CommentsController < ActionController::API
  include JsonWebToken
  before_action :authenticate_api_user!

  def index
    @post = Post.find(params[:post_id])
    if @post.nil?
      render json: { error: 'Post not found' }, status: :not_found
    else
      @comments = @post.comments
      render json: @comments, status: :ok
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = @current_user
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def authenticate_api_user!
    header = request.headers['Authorization']
    head :unauthorized unless header
    header = header.split.last if header
    decoded = jwt_decode(header)
    if decoded[:errors]
      render json: { error: decoded[:errors] }, status: :unauthorized
    else
      @current_user = User.find(decoded[:user_id])
      head :unauthorized unless @current_user
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
