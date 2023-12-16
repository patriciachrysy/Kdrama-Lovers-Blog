def login
  @user = User.find_by(email: params[:email])
  if @user&.valid_password?(params[:password])
    encoded_token = jwt_encode(user_id: @user.id)
    if encoded_token[:errors]
      render json: { error: encoded_token[:errors] }, status: :unauthorized
    else
      render json: { token: encoded_token }, status: :ok
    end
  else
    render json: { error: 'Unauthorized!' }, status: :unauthorized
  end
end
