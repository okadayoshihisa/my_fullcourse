class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :fullcourse_menus, dependent: :destroy

  mount_uploader :fullcourse_image, FullcourseImageUploader

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true
  validates :email, uniqueness: true
end
