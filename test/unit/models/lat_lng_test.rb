require 'test_helper'

class LatLngTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

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
    latlng = LatLng.new(0,0)
    assert latlng.latitude.is_a? BigDecimal
    assert latlng.longitude.is_a? BigDecimal
  end  

end