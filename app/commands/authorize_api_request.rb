# frozen_string_literal: true

# app/commands/authorize_api_request.rb


class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(params = {})
    @params = params
  end

  def call
    user
  end

  private

  attr_reader :params

  def user
    @user ||= Host.find(decoded_auth_token[:host_id]) if decoded_auth_token
    #Check if token is expired or not and make sure it is auth token and not a refresh one
    if Time.at(decoded_auth_token[:exp]) < Time.now && decoded_auth_token[:refresh]
      errors.add(:token, 'Invalid token') && nil
    else
      @user
    end
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)

  end

  def http_auth_header
    if params['auth_token'].present?
      params['auth_token'].split(' ').last
    else
      errors.add :token, 'Missing token'
    end
  end
end
