class Tweet < ActiveRecord::Base
  belongs_to :user
  attr_accessible :coordinates_latitude, :coordinates_longitude, :text, :twitter_id
end
