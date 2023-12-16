class Api::V1::AuthenticationController < ActionController::API
  include JsonWebToken

  def login
    @user = User.find_by(email: params[:email])
    if @user&.valid_password?(params[:password])
      encoded_token = jwt_encode(user_id: @user.id)
      if encoded_token
        render json: { token: encoded_token }, status: :ok
      else
        render json: { error: 'Token encoding failed' }, status: :unauthorized
      end
    else
      render json: { error: 'Unauthorized!' }, status: :unauthorized
    end
  end
end
