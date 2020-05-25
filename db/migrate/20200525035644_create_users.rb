class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :createdEvents, array: true, default: []
      t.string :savedEvents, array: true, default: []

      t.timestamps
    end
  end
end
