# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :host
  validates_associated :host
  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :category, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
