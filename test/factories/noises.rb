# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :noise do
    association :user, factory: :user
    provider "MyProvider"
    provider_id "MyString"
    text "MyText"
    created_at Time.now
  end

  factory :noise_with_coordinates, parent: :noise do
    latitude "9.99"
    longitude "9.99"
  end
end
