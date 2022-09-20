FactoryBot.define do
  factory :store do
    sequence(:name) { |n| "store#{n}_name" }
  end
end
