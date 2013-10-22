# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    association :user, factory: :user
    address Faker::Address.street_address
    city Faker::Address.city
    state Faker::Address.state
    zip Faker::Address.zip

    trait :geocoded do
      latitude Faker::Address.latitude
      longitude Faker::Address.longitude
    end
  end
end
