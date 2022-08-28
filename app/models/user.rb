class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :fullcourse_menus, dependent: :destroy
  has_many :stars, dependent: :destroy
  has_many :star_fullcourses, through: :stars, source: :fullcourse
  has_one :fullcourse, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  mount_uploader :avatar, AvatarUploader

  enum role: { general: 0, admin: 1 }

  def star(fullcourse)
    star_fullcourses << fullcourse
  end

  def delete_star(fullcourse)
    star_fullcourses.destroy(fullcourse)
  end

  def star?(fullcourse)
    star_fullcourses.include?(fullcourse)
  end

  def remaining_number
    menus = fullcourse_menus.map(&:name)
    menus.count('')
  end
end
