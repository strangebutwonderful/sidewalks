require 'test_helper'

class LatLngTest < ActiveSupport::TestCase
  test 'Blank constructor fails' do
    assert_raises RuntimeError do
      LatLng.new(nil, nil)
    end
  end

  test 'Constructor works with string inputs' do
    assert_nothing_raised RuntimeError do
      LatLng.new('0.0', '0.0')
    end
  end

  test 'Constructor works with numeric inputs' do
    assert_nothing_raised RuntimeError do
      LatLng.new(0, 0)
    end
  end

  test 'Constructor works with BigDecimal inputs' do
    assert_nothing_raised RuntimeError do
      LatLng.new(BigDecimal.new('0.0'), BigDecimal.new('0.0'))
    end
  end

  test 'Latitude and longitude are BigDecimals' do
    latlng = LatLng.new(0, 0)
    assert latlng.latitude.is_a? BigDecimal
    assert latlng.longitude.is_a? BigDecimal
  end

  test 'LatLng equals tests against latitude and longitude' do
    assert_equal LatLng.new(0, 0), LatLng.new(0, 0)
    assert_not_equal LatLng.new(0, 0), LatLng.new(1, 1)
  end

  test 'Expand by north eastern should move north east' do
    latlng = LatLng.new(0, 0).expand_north_east(LatLng.new(1, 2))

    assert_equal BigDecimal(1), latlng.latitude
    assert_equal BigDecimal(2), latlng.longitude
  end

  test 'Expand by south western does not move north east' do
    latlng = LatLng.new(1, 2).expand_north_east(LatLng.new(0, 0))

    assert_equal BigDecimal(1), latlng.latitude
    assert_equal BigDecimal(2), latlng.longitude
  end

  test 'Expand by south western moves south west' do
    latlng = LatLng.new(1, 2).expand_south_west(LatLng.new(0, 1))

    assert_equal BigDecimal(0), latlng.latitude
    assert_equal BigDecimal(1), latlng.longitude
  end

  test 'Expand by north eastern does not move south west' do
    latlng = LatLng.new(0, 1).expand_south_west(LatLng.new(1, 2))

    assert_equal BigDecimal(0), latlng.latitude
    assert_equal BigDecimal(1), latlng.longitude
  end

  test 'Center should generate the same value latlng for a single entry list' do
    centered_latlng = LatLng.center([LatLng.new(10, 15)])

    assert_equal BigDecimal(10), centered_latlng.latitude
    assert_equal BigDecimal(15), centered_latlng.longitude
  end

  test 'Center should generate the average latlng for a list' do
    centered_latlng = LatLng.center([LatLng.new(1, 1), LatLng.new(3, 3)])

    assert_equal BigDecimal(2), centered_latlng.latitude
    assert_equal BigDecimal(2), centered_latlng.longitude
  end
end
