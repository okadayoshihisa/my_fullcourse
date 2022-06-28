class FullcourseMenu < ApplicationRecord
  belongs_to :user

  # validates :genre, presence: true

  enum genre: { "hors_d'oeuvre": 0, soup: 1, seafood_dish: 2, meat_dish: 3,
                main_dish: 4, salad: 5, dessert: 6, drink: 7 }
end
