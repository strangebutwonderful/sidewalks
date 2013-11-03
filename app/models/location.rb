# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  address    :string(255)      not null
#  city       :string(255)      not null
#  state      :string(255)      not null
#  zip        :integer          not null
#  latitude   :decimal(11, 8)
#  longitude  :decimal(11, 8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :address, :city, :latitude, :longitude, :state, :zip

  validates :zip, :numericality => true, :allow_nil => true
  validates_presence_of :user_id, :address, :city, :state

  after_validation :geocode # geocoder 

  geocoded_by :full_street_address do |location, results|
    if geocode = results.first
      location.latitude ||= geocode.latitude
      location.longitude ||= geocode.longitude
      location.zip ||= geocode.postal_code
    end
  end

  def full_street_address
    address + ', ' + city + ', ' + state + ' ' + zip.to_s
  end
end
