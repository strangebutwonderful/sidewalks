class Location < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :address, :city, :latitude, :longitude, :state, :zip
end
