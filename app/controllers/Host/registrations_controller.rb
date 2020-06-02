# frozen_string_literal: true


class Host::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: %i[create]
  before_action :configure_account_update_params, only: %i[update]

  # GET /resource/sign_up
  def new
    @host_sign_up = Host.create(host_params)
    if @host_sign_up.save
      render :host_sign_up, status: :ok
    else
      render json: {
        status: 'ERROR', message: 'Host Not Saved', data: @host_sign_up.errors
      },status: :unprocessable_entity
    end
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[attribute])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end

  def host_params
    params.permit(:email, :name,  :password, :password_confirmation)
  end
end
