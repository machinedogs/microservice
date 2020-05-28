# frozen_string_literal: true

class User < ApplicationRecord
  has_many :events, foreign_key: 'user_id'
  # serialize :createdEvents, :savedEvents
end
