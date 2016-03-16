require "test_helper"

class MapTest < ActiveSupport::TestCase
  test "Constructor works with latitude and longitude" do
    latlng = LatLng.new(Faker::Address.latitude, Faker::Address.longitude)
    assert_not_nil Map.new(latlng)
  end

  test "Bounding box not null" do
    latlng = LatLng.new(Faker::Address.latitude, Faker::Address.longitude)
    assert_not_nil Map.new(latlng).bounding_box
  end

  test "LatLngs set on constructor" do
    latlngs = []
    5.times do
      latlngs << LatLng.new(Faker::Address.latitude, Faker::Address.longitude)
    end

    assert_equal 5, Map.new(latlngs).latlngs.count
    assert_equal latlngs, Map.new(latlngs).latlngs
  end

  test "Map bounding box should map the latlngs" do
    latlngs = [
      LatLng.new(0, 2),
      LatLng.new(1, 1),
      LatLng.new(2, 0)
    ]
    expected_boundary = [[0, 0], [2, 2]]

    assert_equal expected_boundary, Map.new(latlngs).bounding_box
  end

  test "Map center should be in the middle" do
    latlngs = [
      LatLng.new(0, 0),
      LatLng.new(2, 2)
    ]
    expected_center = [BigDecimal.new(1), BigDecimal.new(1)]

    assert_equal expected_center, Map.new(latlngs).center
  end
end
