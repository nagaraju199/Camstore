class Api::V1::HomeController < ApplicationController
  def login
    user = User.where(email: params[:email]).first
    if user&.valid_password?(params[:password])
      render json: { token: user.token, message: 'Sign In Successfully', status: 'success' }
    else
      render json: { message: 'Invalid email or password', status: 'failed' }
    end
  end
end
