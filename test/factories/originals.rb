# == Schema Information
#
# Table name: originals
#
#  id              :integer          not null, primary key
#  importable_id   :integer          not null
#  importable_type :string(255)      not null
#  dump            :json             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :noise_original, :class => Original do
    association :importable, factory: :noise

    dump { OpenStruct.new().to_json }
  end

  factory :user_original, :class => Original do
    association :importable, factory: :user

    dump { OpenStruct.new().to_json }
  end
end
