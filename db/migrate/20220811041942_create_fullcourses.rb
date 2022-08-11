class CreateFullcourses < ActiveRecord::Migration[6.1]
  def change
    create_table :fullcourses do |t|
      t.references :user, index: { unique: true }, null: false, foreign_key: true
      t.string :fullcourse_image, null: false

      t.timestamps
    end
  end
end
