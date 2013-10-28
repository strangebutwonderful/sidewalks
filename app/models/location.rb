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

  validates_presence_of :user_id, :address, :city, :state, :zip
end
