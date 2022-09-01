class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.float :latitude
      t.float :longitude

      t.timestamps
      t.index [:name, :address, :latitude, :longitude], unique: true
    end
  end
end
