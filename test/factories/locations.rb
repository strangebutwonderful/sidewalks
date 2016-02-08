# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  address    :string(255)      not null
#  city       :string(255)      default("San Francisco"), not null
#  state      :string(255)      default("CA"), not null
#  zip        :integer          not null
#  latitude   :decimal(11, 8)   not null
#  longitude  :decimal(11, 8)   not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_locations_on_latitude_and_longitude  (latitude,longitude)
#  index_locations_on_user_id                 (user_id)
#  unique_user_and_locations                  (user_id,address,city,state,zip) UNIQUE
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    association :user, factory: :user
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    trait :san_francisco_city_hall do
      address '1 Dr Carlton B Goodlett Pl'
      city 'San Francisco'
      state 'CA'
      zip 94_102
    end
  end
end
