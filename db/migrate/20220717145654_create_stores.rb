class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.float :latitude
      t.float :longitude

      t.timestamps
      t.index [:name, :address, :latitude, :longitude, :phone_number], unique: true, name: 'stores_unique_index'
    end
  end
end
