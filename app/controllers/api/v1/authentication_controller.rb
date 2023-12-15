class Api::V1::AuthenticationController < ActionController::API
  include JsonWebToken

  def login
    @user = User.find_by(email: params[:email])
    if @user&.valid_password?(params[:password])
      token = jwt_encode(user_id: @user.id)
      render json: { token: }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
