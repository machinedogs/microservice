# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :users, foreign_key: 'event_id'
end
