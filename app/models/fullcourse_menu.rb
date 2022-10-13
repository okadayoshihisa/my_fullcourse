class FullcourseMenu < ApplicationRecord
  belongs_to :user
  belongs_to :store

  validates :name, presence: true, if: proc { |f| f.store.name.present? }
  validates :genre, presence: true
  validate :menu_limit, on: :create

  def menu_limit
    errors.add(:base, '登録できるフルコースメニューは8つまでです') if user.fullcourse_menus.count >= 8
  end

  mount_uploader :menu_image, MenuImageUploader

  enum genre: { "hors_d'oeuvre": 0, soup: 1, seafood_dish: 2, meat_dish: 3,
                main_dish: 4, salad: 5, dessert: 6, drink: 7 }
end
