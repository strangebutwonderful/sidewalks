# == Schema Information
#
# Table name: origins
#
#  id         :integer          not null, primary key
#  noise_id   :integer          not null
#  latitude   :decimal(11, 8)   not null
#  longitude  :decimal(11, 8)   not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_origin_on_latitude_and_longitude  (noise_id,latitude,longitude) UNIQUE
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :origin do
    association :noise, factory: :noise

    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    Neighborhood::districts.each do |key, district|
      trait key do
        latitude district.latitude
        longitude district.longitude
      end
    end
  end

  factory :week_old_origin, parent: :noise do
    created_at { 1.week.ago }
  end
end
