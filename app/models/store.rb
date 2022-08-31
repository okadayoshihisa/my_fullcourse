class Store < ApplicationRecord
  has_many :fullcourse_menus, dependent: :destroy

  validates :name, uniqueness: { scope: :address }
end
