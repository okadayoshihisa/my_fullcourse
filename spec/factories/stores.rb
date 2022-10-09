FactoryBot.define do
  factory :store do
    sequence(:name) { |n| "store#{n}_name" }
    sequence(:address, 'test_address_1')
    latitude { 35.676192 }
    longitude { 139.650311 }
  end
end
