class Word < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :score, presence: true
  validates :category, presence: true

  enum category: { menu: 0, place: 1 }
end
