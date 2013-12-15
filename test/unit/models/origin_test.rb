# == Schema Information
#
# Table name: origins
#
#  id         :integer          not null, primary key
#  noise_id   :integer          not null
#  latitude   :decimal(11, 8)   not null
#  longitude  :decimal(11, 8)   not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_origin_on_latitude_and_longitude  (noise_id,latitude,longitude) UNIQUE
#

require 'test_helper'

class OriginTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "FactoryGirl works" do
    assert_difference('Origin.count') do
      FactoryGirl.create(:origin)
    end
  end  
end
