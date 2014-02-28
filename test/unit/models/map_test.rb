require 'test_helper'

class MapTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Constructor works with latitude and longitude" do
    latlng = LatLng.new(Faker::Address.latitude, Faker::Address.longitude)
    assert_not_nil Map.new(latlng)
  end

  test "Boundaries not null" do
    latlng = LatLng.new(Faker::Address.latitude, Faker::Address.longitude)
    assert_not_nil Map.new(latlng).boundaries
  end  

end