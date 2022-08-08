class Store < ApplicationRecord
  has_many :fullcourse_menus, dependent: :destroy
end
