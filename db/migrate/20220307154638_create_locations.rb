class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :map_url
      t.text :address
      t.integer :owner_id

      t.timestamps
    end
  end
end
