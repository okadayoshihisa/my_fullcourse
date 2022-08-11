class CreateStars < ActiveRecord::Migration[6.1]
  def change
    create_table :stars do |t|
      t.references :user, null: false, foreign_key: true
      t.references :fullcourse, null: false, foreign_key: true

      t.timestamps
      t.index [:user_id, :fullcourse_id], unique: true
    end
  end
end
