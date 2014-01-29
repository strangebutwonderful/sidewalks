# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trail do
    association :user, factory: :user
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
