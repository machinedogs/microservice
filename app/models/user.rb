# frozen_string_literal: true

class User < ApplicationRecord
  has_many :event
  # validates_presence_of :email, :password
  # serialize :createdEvents, :savedEvents
end
