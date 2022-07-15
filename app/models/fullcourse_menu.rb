class FullcourseMenu < ApplicationRecord
  belongs_to :user

  validates :genre, presence: true
  validate :menu_limit

  mount_uploader :menu_image, MenuImageUploader

  enum genre: { "hors_d'oeuvre": 0, soup: 1, seafood_dish: 2, meat_dish: 3,
                main_dish: 4, salad: 5, dessert: 6, drink: 7 }

  def self.multi_update(edit_fullcourse_menu_params)
    FullcourseMenu.transaction do
      edit_fullcourse_menu_params.to_h.map do |id, edit_fullcourse_menu_param|
        fullcourse_menu = self.find(id)
        fullcourse_menu.update!(edit_fullcourse_menu_param)
      end
    end
      true
    rescue StandardError => e
      false
  end

  def menu_limit
    if user.fullcourse_menus.count > 8
      errors.add(:fullcourse_menu, "登録できるのは8つまでです")
    end
  end
end
