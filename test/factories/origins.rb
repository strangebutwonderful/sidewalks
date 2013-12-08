# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :origin do
    association :noise, factory: :noise

    latitude Faker::Address.latitude
    longitude Faker::Address.longitude
  end
end
