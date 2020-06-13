# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.belongs_to :host
      t.string :title
      t.text :description
      t.string :date
      t.string :category
      t.string :latitude
      t.string :longitude
      t.string :image

      t.timestamps
    end
  end
end
