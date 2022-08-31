class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :phone_number

      t.timestamps
      t.index [:name, :address], unique: true
    end
  end
end
