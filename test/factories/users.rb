# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :provider_id do |n|
    "MyProviderId#{n}"
  end

  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    provider "MyString"
    provider_id
    provider_screen_name Faker::Internet.user_name
  end

  factory :admin_user, parent: :user do
    after(:create) {| user| user.add_role(:admin) }
  end

end
