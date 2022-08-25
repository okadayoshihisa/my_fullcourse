class CreateWords < ActiveRecord::Migration[6.1]
  def change
    create_table :words do |t|
      t.string :name, null: false, index: { unique: true }
      t.integer :score, null: false
      t.integer :category, null: false

      t.timestamps
    end
  end
end
