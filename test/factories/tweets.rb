# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do
    twitter_id "MyString"
    user nil
    text "MyText"
    coordinates_longitude "9.99"
    coordinates_latitude "9.99"
  end
end
