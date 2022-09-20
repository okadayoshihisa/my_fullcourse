FactoryBot.define do
  factory :fullcourse_menu do
    sequence(:name) { |n| "menu#{n}_name" }
    genre { 0 }
    association :user
    association :store
  end
end
