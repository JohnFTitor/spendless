require 'faker'

FactoryBot.define do 
  factory :user do
    name { Faker::Name.name }
    confirmed_at { DateTime.now }
    password { 123456 }

    trait :email do
      email { Faker::Internet.unique.email }
    end
  end
end
