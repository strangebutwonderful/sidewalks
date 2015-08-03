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
#  latitude   :decimal(11, 8)
#  longitude  :decimal(11, 8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_locations_on_latitude_and_longitude  (latitude,longitude)
#  index_locations_on_user_id                 (user_id)
#  unique_user_and_locations                  (user_id,address,city,state,zip) UNIQUE
#

require "test_helper"

class LocationTest < ActiveSupport::TestCase
end
