class Origin < ActiveRecord::Base
  belongs_to :noise
  
  attr_accessible :latitude, :longitude
end
