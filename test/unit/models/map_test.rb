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

  test "LatLngs set on constructor" do
    latlngs = []
    5.times do
      latlngs << LatLng.new(Faker::Address.latitude, Faker::Address.longitude)
    end

    assert_equal 5, Map.new(latlngs).latlngs.count
    assert_equal latlngs, Map.new(latlngs).latlngs
  end

  test "Map southwest boundary should be in the southwest" do
    latlngs = [
      LatLng.new(0, 0),
      LatLng.new(2, 2)
    ]
    expected_boundary = LatLng.new(BigDecimal.new(0), BigDecimal.new(0))

    assert_equal expected_boundary, Map.new(latlngs).south_west_boundary_latlng
  end

  test "Map northeast boundary should be in the northeast" do
    latlngs = [
      LatLng.new(2, 2),
      LatLng.new(0, 0)
    ]
    expected_boundary = LatLng.new(BigDecimal.new(2), BigDecimal.new(2))

    assert_equal expected_boundary, Map.new(latlngs).north_east_boundary_latlng
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
