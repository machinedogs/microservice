# frozen_string_literal: true

require 'byebug'
class ApplicationController < ActionController::API
  attr_reader :current_user
  # helper_method :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result

    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
