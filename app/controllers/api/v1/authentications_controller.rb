# frozen_string_literal: true

class Api::V1::AuthenticationsController < ApplicationController
  skip_before_action :authenticate_request



  #This method will take in user email and password(hashed password eventually), authenticate the  user, and return  the  jwt token on successful  login
  # Give Client authentication token
  def create
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end




  # private

  # def login_params
  #   params.permit(:email, :password)
  # end
end
