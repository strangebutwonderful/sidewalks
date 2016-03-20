require "test_helper"

class LatLngGroupTest < ActiveSupport::TestCase
  test "Blank constructor succeeds" do
    assert_nothing_raised RuntimeError do
      LatLngGroup.new(nil)
    end
  end

  test "Constructor works with basic input" do
    lat_lng = LatLng.new(0, 0)
    assert_nothing_raised RuntimeError do
      LatLngGroup.new([lat_lng])
    end
  end

  test "#center should generate the same value lat_lng for a single entry list" do
    lat_lng_group = LatLngGroup.new([LatLng.new(1, 1)])
    centered_lat_lng = lat_lng_group.center

    assert_equal BigDecimal(1), centered_lat_lng.latitude
    assert_equal BigDecimal(1), centered_lat_lng.longitude
  end

  test "#center should generate the average lat_lng for a list" do
    lat_lng_group = LatLngGroup.new(
      [LatLng.new(1, 1), LatLng.new(3, 3)]
    )
    centered_lat_lng = lat_lng_group.center

    assert_equal BigDecimal(2), centered_lat_lng.latitude
    assert_equal BigDecimal(2), centered_lat_lng.longitude
  end
end
