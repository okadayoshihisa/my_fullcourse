class AddStoreToFullcourseMenus < ActiveRecord::Migration[6.1]
  def change
    add_reference :fullcourse_menus, :store, null: false, foreign_key: true
  end
end
