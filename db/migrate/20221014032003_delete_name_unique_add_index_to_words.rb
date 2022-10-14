class DeleteNameUniqueAddIndexToWords < ActiveRecord::Migration[6.1]
  def change
    remove_index :words, :name
    add_index :words, [:name, :category], unique: true
  end
end
