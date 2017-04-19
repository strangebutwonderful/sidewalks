# == Schema Information
#
# Table name: origins
#
#  id         :integer          not null, primary key
#  noise_id   :integer          not null
#  latitude   :decimal(11, 8)   not null
#  longitude  :decimal(11, 8)   not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_origin_on_latitude_and_longitude  (noise_id,latitude,longitude) UNIQUE
#

class Origin < ApplicationRecord
  belongs_to :noise
  has_one :user, through: :noise

  reverse_geocoded_by :latitude, :longitude

  scope :where_since, ->(time) do
    where("#{table_name}.created_at >= ?", time).
      order(created_at: :desc)
  end

  scope :where_nearby, ->(latitude, longitude, distance) do
    near([latitude.to_f, longitude.to_f], distance)
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

  def directions_url
    "http://maps.google.com/maps?daddr=" + latitude.to_s + "," + longitude.to_s
  end
end
