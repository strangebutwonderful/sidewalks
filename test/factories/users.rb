# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
    email "MyString@example.com"
    provider "MyString"
    provider_id "MyString"
    provider_screen_name "MyString"
  end
end
