class FullcourseMenu < ApplicationRecord
  belongs_to :user
  belongs_to :store

  validate :menu_limit
  validates :name, presence: true, if: proc { |f| f.store.name.present? }
  validates :genre, presence: true
  validate :store_name_presence

  mount_uploader :menu_image, MenuImageUploader

  enum genre: { "hors_d'oeuvre": 0, soup: 1, seafood_dish: 2, meat_dish: 3,
                main_dish: 4, salad: 5, dessert: 6, drink: 7 }

  def menu_limit
    errors.add(:base, 'フルコースメニューを登録できるのは8つまでです') if user.fullcourse_menus.size > 8
  end

  def store_name_presence
    store.errors.add(:name, 'を入力してください') if name.present? && store.name.blank?
  end
end
