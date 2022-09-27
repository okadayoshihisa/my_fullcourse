class Fullcourse < ApplicationRecord
  belongs_to :user
  has_many :stars, dependent: :destroy

  validates :fullcourse_image, presence: true

  mount_uploader :fullcourse_image, FullcourseImageUploader
end
