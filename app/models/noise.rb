# == Schema Information
#
# Table name: noises
#
#  id          :integer          not null, primary key
#  provider_id :string(255)      not null
#  user_id     :integer          not null
#  text        :text             not null
#  longitude   :decimal(11, 8)
#  latitude    :decimal(11, 8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  provider    :string(255)      not null
#

class Noise < ActiveRecord::Base
  belongs_to :user
  attr_accessible :latitude, :longitude, :text, :provider, :provider_id

  attr_reader :provider_url, :user_name, :user_provider_url

  validates_presence_of :provider, :provider_id, :text, :created_at, :user_id

  reverse_geocoded_by :latitude, :longitude

  PROVIDER_TWITTER = 'twitter'

  def provider_url
    self.user && self.user.provider_url + "/status/" + provider_id
  end

  def user_name
    self.user && self.user.name
  end

  def user_provider_url
    self.user && self.user.provider_url
  end

  def import_from_twitter_noise(twitter_noise, user)
    logger.info "Creating a noise from twitter noise: [#{twitter_noise.inspect}]" 
    
    self.user_id = user.id

    self.provider = Noise::PROVIDER_TWITTER

    self.provider_id = twitter_noise.try(:id).to_s
    self.text = twitter_noise.try(:text)
    self.created_at = twitter_noise.try(:created_at)
    
    # TODO: get tweet's embedded coordinates
    if user.locations.first
      self.longitude = user.locations.first.longitude
      self.latitude = user.locations.first.latitude
    end
    
    save!
  end

  def self.latest
    Noise.where('created_at >= ?', 24.hours.ago).order('created_at DESC')
  end

  def self.located
    Noise.where('longitude IS NOT NULL').where('latitude IS NOT NULL')
  end

  def self.first_or_import_from_twitter_noise(twitter_noise, user) 
    Noise.where(:provider => Noise::PROVIDER_TWITTER, :provider_id => twitter_noise.id.to_s).first_or_create do |noise|
      noise.import_from_twitter_noise(twitter_noise, user)
    end
  end

end
