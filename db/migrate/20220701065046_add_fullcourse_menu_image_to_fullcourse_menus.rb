class AddFullcourseMenuImageToFullcourseMenus < ActiveRecord::Migration[6.1]
  def change
    add_column :fullcourse_menus, :fullcourse_menu_image, :string
  end
end
