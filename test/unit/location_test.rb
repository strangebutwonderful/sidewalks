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

require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
