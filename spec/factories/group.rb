require 'faker'

FactoryBot.define do 
  factory :group do
    name { Faker::Company.name }
    icon { 'URL' }

    trait :author do
      author { nil }
    end
  end
end
