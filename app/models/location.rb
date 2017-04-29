# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  address    :string(255)      not null
#  city       :string(255)      default("San Francisco"), not null
#  state      :string(255)      default("CA"), not null
#  zip        :integer          not null
#  latitude   :decimal(11, 8)   not null
#  longitude  :decimal(11, 8)   not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_locations_on_latitude_and_longitude  (latitude,longitude)
#  index_locations_on_user_id                 (user_id)
#  unique_user_and_locations                  (user_id,address,city,state,zip) UNIQUE
#

class Location < ApplicationRecord
  belongs_to :user, counter_cache: true

  validates_presence_of :user_id, :address, :city, :latitude, :longitude, :state, :zip

  geocoded_by :full_street_address do |location, results|
    results.first.tap do |geocode|
      location.latitude ||= geocode.latitude
      location.longitude ||= geocode.longitude
      location.zip ||= geocode.postal_code
    end
  end

  def lat_lng?
    latitude.present? && longitude.present?
  end

  def lat_lng
    @lat_lng ||= LatLng.new(latitude, longitude) if lat_lng?
  end

  def map
    @map ||= Map.new(lat_lngs) if lat_lngs?
  end

  def full_street_address
    address + ", " + city + ", " + state + " " + zip.to_s
  end

  def geography_changed?
    address_changed? ||
      city_changed? ||
      state_changed? ||
      zip_changed?
  end

  def to_origin
    Origin.new(latitude: latitude, longitude: longitude)
  end
end
