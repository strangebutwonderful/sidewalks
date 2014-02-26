# == Schema Information
#
# Table name: trails
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  latitude   :decimal(11, 8)   not null
#  longitude  :decimal(11, 8)   not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_trails_on_latitude   (latitude)
#  index_trails_on_longitude  (longitude)
#  index_trails_on_user_id    (user_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trail do
    association :user, factory: :user
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
