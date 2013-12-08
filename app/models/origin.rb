class Origin < ActiveRecord::Base
  belongs_to :noise
  
  attr_accessible :latitude, :longitude

  reverse_geocoded_by :latitude, :longitude
end
