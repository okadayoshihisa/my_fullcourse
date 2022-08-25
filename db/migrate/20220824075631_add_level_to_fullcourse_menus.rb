class AddLevelToFullcourseMenus < ActiveRecord::Migration[6.1]
  def change
    add_column :fullcourse_menus, :level, :integer
  end
end
