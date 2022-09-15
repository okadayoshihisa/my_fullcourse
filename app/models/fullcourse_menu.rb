class FullcourseMenu < ApplicationRecord
  belongs_to :user
  belongs_to :store

  validate :menu_limit
  validates :name, presence: true, if: proc { |f| f.store.name.present? }
  validates :genre, presence: true
  validate :store_name_present

  mount_uploader :menu_image, MenuImageUploader

  enum genre: { "hors_d'oeuvre": 0, soup: 1, seafood_dish: 2, meat_dish: 3,
                main_dish: 4, salad: 5, dessert: 6, drink: 7 }

  def menu_limit
    errors.add(:fullcourse_menu, '登録できるのは8つまでです') if user.fullcourse_menus.count > 8
  end

  def store_name_present
    errors.add(:base, '店名を入力してください') if name.present? && store.name.blank?
  end

  def calculate_level
    size_score = name.size
    word_score = Word.all.filter_map do |word|
      if word.menu?
        word.score if name.include?(word.name)
      elsif store.address.include?(word.name)
        word.score
      end
    end
    word_score.push(100) unless store.address.include?('日本')
    size_score + word_score.sum
  end
end
