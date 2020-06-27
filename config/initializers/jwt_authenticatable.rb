# frozen_string_literal: true

module Devise
  module Strategies
    class JWTAuthenticatable < Base
      # Here check if JWT token is expired or not
      def authenticate!
        @user = AuthorizeApiRequest.call(params).result
        user ? success!(user) : fail!('Invalid email or password')
      end
    end
  end
end
