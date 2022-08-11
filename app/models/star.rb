class Star < ApplicationRecord
  belongs_to :user
  belongs_to :fullcourse

  validates :user_id, uniqueness: { scope: :fullcourse_id }
end
