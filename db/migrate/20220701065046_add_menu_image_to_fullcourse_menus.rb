class AddMenuImageToFullcourseMenus < ActiveRecord::Migration[6.1]
  def change
    add_column :fullcourse_menus, :menu_image, :string
  end
end
