# frozen_string_literal: true

require 'byebug'
class Host::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_host! # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new

    puts "Params Here "

    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      @host_sign_in = Host.where(email: params[:email]).first
      render :host_sign_in, status: :ok
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
