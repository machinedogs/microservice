# frozen_string_literal: true



module JsonWebToken
  def self.encode(payload, exp = 24.hours.from_now)
    puts "Payload Here"
    puts payload 
    puts "Payload ^"
    payload[:exp] = exp.to_i
    JWT.encode(payload, ENV['SECRET_KEY_BASE'])
  end

  def self.decode(token)
    body = JWT.decode(token, ENV['SECRET_KEY_BASE'])[0]
    HashWithIndifferentAccess.new body
  rescue StandardError
    nil
  end

  def self.secret_key
    Rails.application.secrets&.secret_key_base ||
      Rails.application.credentials&.secret_key_base
  end
end
