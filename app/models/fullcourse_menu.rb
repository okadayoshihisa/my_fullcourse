class FullcourseMenu < ApplicationRecord
  belongs_to :user
  belongs_to :store

  validates :genre, presence: true
  validate :menu_limit

  mount_uploader :menu_image, MenuImageUploader

  enum genre: { "hors_d'oeuvre": 0, soup: 1, seafood_dish: 2, meat_dish: 3,
                main_dish: 4, salad: 5, dessert: 6, drink: 7 }

  def menu_limit
    errors.add(:fullcourse_menu, '登録できるのは8つまでです') if user.fullcourse_menus.count > 8
  end
end
