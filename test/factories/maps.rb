
FactoryGirl.define do
  factory :map do
    coordinates { [Faker::Address.latitude, Faker::Address.longitude] }
  end
end
