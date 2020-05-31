# frozen_string_literal: true

require 'byebug'

module Devise
  module Strategies
    class JWTAuthenticatable < Base # Here check if there is token present
      def authenticate!

        user ? success!(user) : fail!('Invalid email or password')
      end

      def user
        @user ||= Host.find(decoded_auth_token[:user_id]) if decoded_auth_token
        @user || errors.add(:token, 'Invalid token') && nil
      end

      def decoded_auth_token
        @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
      end

      def http_auth_header
        if params['auth_key'].present?
          params['auth_key'].split(' ').last
        else
          errors.add :token, 'Missing token'
        end
      end
    end
  end
end
