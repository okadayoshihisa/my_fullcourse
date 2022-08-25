class Word < ApplicationRecord
  with_options presence: true do
    validates :score
    with_options uniqueness: true do
      validates :name
      validates :category
    end
  end

  enum category: { menu: 0, place: 1 }
end
