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

  scope :where_created_after, ->(time) do
    where("#{table_name}.created_at >= ?", time)
  end

  def latlng
    @latlng ||= LatLng.new(latitude, longitude)
  end

end
