class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :fullcourse_menus, dependent: :destroy
  has_many :stars, dependent: :destroy
  has_many :star_fullcourses, through: :stars, source: :fullcourse
  has_one :fullcourse, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true
  validates :email, uniqueness: true

  def multi_update(edit_fullcourse_menu_params)
    FullcourseMenu.transaction do
      edit_fullcourse_menu_params[:fullcourse_menus].to_h.map.with_index do |edit_fullcourse_menu_param, index|
        fullcourse_menus.order(id: :asc)[index].update(edit_fullcourse_menu_param[1])
      end
      edit_fullcourse_menu_params[:stores].to_h.map.with_index do |edit_fullcourse_menu_param, index|
        fullcourse_menus.order(id: :asc)[index].store.update(edit_fullcourse_menu_param[1])
      end
    end
    true
  rescue StandardError => e
    false
  end

  def star(fullcourse)
    star_fullcourses << fullcourse
  end

  def delete_star(fullcourse)
    star_fullcourses.destroy(fullcourse)
  end

  def star?(fullcourse)
    star_fullcourses.include?(fullcourse)
  end
end
