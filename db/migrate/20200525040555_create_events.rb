class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :hostName
      t.string :title
      t.text :description
      t.date :date
      t.string :typeId
      t.decimal :latitude,  :precision => 15, :scale => 10
      t.decimal :longitude , :precision => 15, :scale => 10

      t.timestamps
    end
  end
end
