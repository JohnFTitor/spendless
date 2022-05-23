require 'faker'

FactoryBot.define do 
  factory :operation do
    name { Faker::Commerce.product_name }
    amount { rand(1..10000) }

    trait :author do
      author { nil }
    end
  end
end
