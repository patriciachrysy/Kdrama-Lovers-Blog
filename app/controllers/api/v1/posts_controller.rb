class Api::V1::PostsController < ActionController::API
  include JsonWebToken
  before_action :authenticate_api_user!

  def index
    @user = User.find(params[:id])
    if @user.nil?
      render json: { error: 'User not found' }, status: :not_found
    else
      @posts = @user.posts
      render json: @posts, status: :ok
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
end
