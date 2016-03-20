require "test_helper"

class LatLngGroupTest < ActiveSupport::TestCase
  test "Blank constructor succeeds" do
    assert_nothing_raised RuntimeError do
      LatLngGroup.new(nil)
    end
  end

  test "Constructor works with basic input" do
    latlng = LatLng.new(0, 0)
    assert_nothing_raised RuntimeError do
      LatLngGroup.new([latlng])
    end
  end

  test "#center should generate the same value latlng for a single entry list" do
    latlng_group = LatLngGroup.new([LatLng.new(1, 1)])
    centered_latlng = latlng_group.center

    assert_equal BigDecimal(1), centered_latlng.latitude
    assert_equal BigDecimal(1), centered_latlng.longitude
  end

  test "#center should generate the average latlng for a list" do
    latlng_group = LatLngGroup.new(
      [LatLng.new(1, 1), LatLng.new(3, 3)]
    )
    centered_latlng = latlng_group.center

    assert_equal BigDecimal(2), centered_latlng.latitude
    assert_equal BigDecimal(2), centered_latlng.longitude
  end
end
