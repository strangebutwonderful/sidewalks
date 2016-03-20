require "test_helper"

class MapTest < ActiveSupport::TestCase
  test "Constructor works with latitude and longitude" do
    lat_lng = LatLng.new(Faker::Address.latitude, Faker::Address.longitude)
    assert_not_nil Map.new(lat_lng)
  end

  test "Bounding box not null" do
    lat_lng = LatLng.new(Faker::Address.latitude, Faker::Address.longitude)
    assert_not_nil Map.new(lat_lng).bounding_box
  end

  test "LatLngs set on constructor" do
    lat_lngs = []
    5.times do
      lat_lngs << LatLng.new(Faker::Address.latitude, Faker::Address.longitude)
    end

    assert_equal 5, Map.new(lat_lngs).lat_lng_group.count
    assert_equal lat_lngs, Map.new(lat_lngs).lat_lng_group.lat_lngs
  end

  test "Map bounding box should map the lat_lngs" do
    lat_lngs = [
      LatLng.new(0, 2),
      LatLng.new(1, 1),
      LatLng.new(2, 0)
    ]
    expected_boundary = [[0, 0], [2, 2]]

    assert_equal expected_boundary, Map.new(lat_lngs).bounding_box
  end

  test "Map center should be in the middle" do
    lat_lngs = [
      LatLng.new(0, 0),
      LatLng.new(2, 2)
    ]
    expected_center = [BigDecimal.new(1), BigDecimal.new(1)]

    assert_equal expected_center, Map.new(lat_lngs).center
  end
end
