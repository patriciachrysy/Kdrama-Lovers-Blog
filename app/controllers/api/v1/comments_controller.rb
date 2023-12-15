class Api::V1::CommentsController < ActionController::API
  include JsonWebToken
  before_action :authenticate_api_user!

  def index
    @post = Post.find(params[:id])
    if @post.nil?
      render json: { error: 'Post not found' }, status: :not_found
    else
      @comments = @post.comments
      render json: @comments, status: :ok
    end
  end

  private

  def authenticate_api_user!
    header = request.headers['Authorization']
    head :unauthorized unless header
    header = header.split.last if header
    decoded = jwt_decode(header)
    head :unauthorized unless User.find(decoded[:user_id])
    @current_user = User.find(decoded[:user_id])
  end
end
