# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  name                         :string(255)      not null
#  email                        :string(255)
#  provider                     :string(255)      not null
#  provider_id                  :string(255)      not null
#  provider_screen_name         :string(255)
#  provider_access_token        :string(255)
#  provider_access_token_secret :string(255)
#  created_at                   :datetime
#  updated_at                   :datetime
#  following                    :boolean          default(FALSE), not null
#  locations_count              :integer          default(0), not null
#  mobile_venues_count          :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    sequence :provider_id do |n|
      "MyProviderUserId#{n}"
    end

    name { Faker::Name.name }
    provider "MyString"
    provider_screen_name { Faker::Internet.user_name }

    trait :needs_triage do
      locations_count 0
      mobile_venues_count 0
    end
  end

  factory :admin_user, parent: :user do
    after(:create) { |user| user.add_role(:admin) }
  end

  factory :user_with_original, parent: :user do
    after(:create) do |user|
      user.create_original(dump: user.to_json)
    end
  end

end
