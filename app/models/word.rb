class Word < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :category }
  validates :score, presence: true
  validates :category, presence: true

  enum category: { menu: 0, place: 1, store_name: 2 }
end
