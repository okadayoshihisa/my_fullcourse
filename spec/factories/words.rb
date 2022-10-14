FactoryBot.define do
  factory :word do
    sequence(:name) { |n| "test_name_#{n}" }
    score { rand(100) }
    category { 0 }
  end
end
