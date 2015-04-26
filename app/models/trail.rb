# == Schema Information
#
# Table name: trails
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  latitude   :decimal(11, 8)   not null
#  longitude  :decimal(11, 8)   not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_trails_on_latitude   (latitude)
#  index_trails_on_longitude  (longitude)
#  index_trails_on_user_id    (user_id)
#

class Trail < ActiveRecord::Base
  belongs_to :user

  def latlng
    @latlng ||= LatLng.new(latitude, longitude)
  end

  def self.update_recent(user, latitude, longitude)
    # TODO: should account for close location drift
    trail = user.trails.where(latitude: latitude, longitude: longitude)
      .where_created_less_than(5.minutes.ago)
      .where_latest
      .first_or_create!
  end

  def self.where_latest
    order("#{table_name}.created_at DESC")
  end

  def self.where_created_less_than(time)
    where("#{table_name}.created_at >= ?", time)
  end
end
