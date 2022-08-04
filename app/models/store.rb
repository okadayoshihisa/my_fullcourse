class Store < ApplicationRecord
  has_many :fullcourse_menus

  geocoded_by :address # addressカラムにジオコーディングを実装
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? } # addressカラムが変更(保存や更新)されたらジオコーディングが行われる
end
