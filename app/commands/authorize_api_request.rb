# frozen_string_literal: true

# app/commands/authorize_api_request.rb
require 'byebug'

class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['auth_token'].present?
      return headers['auth_token'].split(' ').last
    else
      errors.add :token, 'Missing token'
    end

    nil
  end
end
