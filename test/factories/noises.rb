# == Schema Information
#
# Table name: noises
#
#  id               :integer          not null, primary key
#  provider_id      :string(255)      not null
#  user_id          :integer          not null
#  text             :text             not null
#  longitude        :decimal(11, 8)
#  latitude         :decimal(11, 8)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  provider         :string(255)      not null
#  avatar_image_url :string(255)
#
# Indexes
#
#  index_noises_on_latitude_and_longitude  (latitude,longitude)
#  index_noises_on_user_id                 (user_id)
#

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

  factory :week_old_noise, parent: :noise do
    created_at 1.week.ago
  end
end
