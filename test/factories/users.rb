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
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

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
    after(:create) { |user| user.add_role(:admin) }
  end

end
