# == Schema Information
#
# Table name: noises
#
#  id               :integer          not null, primary key
#  provider_id      :string(255)      not null
#  user_id          :integer          not null
#  text             :text             not null
#  created_at       :datetime
#  updated_at       :datetime
#  provider         :string(255)      not null
#  avatar_image_url :string(255)
#  actionable       :boolean
#
# Indexes
#
#  index_noises_on_user_id  (user_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :noise do
    sequence :provider_id do |n|
      "MyProviderNoiseId#{n}"
    end

    association :user, factory: :user

    provider { "MyProvider" }
    text { Faker::Lorem.sentences.join(" ") }
    created_at { Time.zone.now }

    Neighborhood.districts.keys.each do |neighborhood_symbol|
      trait neighborhood_symbol do
        after(:create) do |noise|
          FactoryGirl.create_list(:origin, 1, neighborhood_symbol, noise: noise)
        end
      end
    end
  end

  factory :noise_with_original, parent: :noise do
    after(:create) do |noise|
      noise.create_original(dump: noise.to_json)
    end
  end

  factory :noise_with_coordinates, parent: :noise do
    after(:create) do |noise|
      FactoryGirl.create_list(:origin, rand(1..5), noise: noise)
    end
  end

  factory :week_old_noise, parent: :noise do
    created_at { 1.week.ago }
  end
end
