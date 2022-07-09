class AddFullcourseImageToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :fullcourse_image, :string
  end
end
