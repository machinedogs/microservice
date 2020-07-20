# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.belongs_to :host
      t.string :title, null: false, default: ''
      t.text :description, null: false, default: ''
      t.string :date, null: false, default: ''
      t.string :category, null: false, default: ''
      t.string :latitude, null: false, default: ''
      t.string :longitude, null: false, default: ''
      t.string :address, null: false, default: ''
      t.string :image, null: false, default: ''
      # Array of people going to the event
      t.string :going, array: true, default: []
      t.timestamps
    end
  end
end
