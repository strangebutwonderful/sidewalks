require "test_helper"

class LatLngTest < ActiveSupport::TestCase
  test "Blank constructor fails" do
    assert_raises RuntimeError do
      LatLng.new(nil, nil)
    end
  end

  test "Constructor works with string inputs" do
    assert_nothing_raised RuntimeError do
      LatLng.new("0.0", "0.0")
    end
  end

  test "Constructor works with numeric inputs" do
    assert_nothing_raised RuntimeError do
      LatLng.new(0, 0)
    end
  end

  test "Constructor works with BigDecimal inputs" do
    assert_nothing_raised RuntimeError do
      LatLng.new(BigDecimal.new("0.0"), BigDecimal.new("0.0"))
    end
  end

  test "Latitude and longitude are BigDecimals" do
    lat_lng = LatLng.new(0, 0)
    assert lat_lng.latitude.is_a? BigDecimal
    assert lat_lng.longitude.is_a? BigDecimal
  end

  test "LatLng equals tests against latitude and longitude" do
    assert_equal LatLng.new(0, 0), LatLng.new(0, 0)
    assert_not_equal LatLng.new(0, 0), LatLng.new(1, 1)
  end
end
