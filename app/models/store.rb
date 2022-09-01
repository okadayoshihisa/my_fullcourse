class Store < ApplicationRecord
  has_many :fullcourse_menus, dependent: :destroy

  validates :name, uniqueness: { scope: %i[address latitude longitude] }
end
