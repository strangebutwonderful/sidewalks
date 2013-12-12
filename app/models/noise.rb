# == Schema Information
#
# Table name: noises
#
#  id               :integer          not null, primary key
#  provider_id      :string(255)      not null
#  user_id          :integer          not null
#  text             :text             not null
#  longitude        :decimal(11, 8)
#  latitude         :decimal(11, 8)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  provider         :string(255)      not null
#  avatar_image_url :string(255)
#
# Indexes
#
#  index_noises_on_latitude_and_longitude  (latitude,longitude)
#  index_noises_on_user_id                 (user_id)
#

class Noise < ActiveRecord::Base
  belongs_to :user
  has_many :origins
  
  attr_accessible :latitude, :longitude, :text, :provider, :provider_id

  attr_reader :provider_url, :user_name, :user_provider_url

  validates_presence_of :provider, :provider_id, :text, :created_at, :user_id

  reverse_geocoded_by :latitude, :longitude

  PROVIDER_TWITTER = 'twitter'

  def google_map_url
    "https://maps.google.com/maps?ll=" + self.latitude + ',' + self.longitude
  end

  def provider_url
    self.user && self.user.provider_url + "/status/" + provider_id
  end

  def user_name
    self.user && self.user.name
  end

  def user_provider_url
    self.user && self.user.provider_url
  end

  def has_coordinates?
    return true if self.latitude && self.longitude
  end

  # temporary function to help migrate noise columsn to origins table
  def to_origin 
    if self.has_coordinates?
      self.origins << Origin.new(latitude: self.latitude, longitude: self.longitude)
    end
  end

  def import_from_twitter_noise(twitter_noise, user)
    logger.info "Creating a noise from twitter noise: [#{twitter_noise.inspect}]" 
    
    self.user_id = user.id

    self.provider = Noise::PROVIDER_TWITTER

    self.avatar_image_url = twitter_noise.try(:profile_image_url_https)
    self.created_at = twitter_noise.try(:created_at)
    self.provider_id = twitter_noise.try(:id).to_s
    self.text = twitter_noise.try(:text)

    save!
  end

  def import_locations(locations)
    # TODO: get tweet's embedded coordinates

    # Support old system of one location only while migrating
    if locations.first
      self.longitude = locations.first.longitude
      self.latitude = locations.first.latitude
    end
    # end old support

    locations.each do |location|
      self.origins << location.to_origin
    end
  end

  def self.where_search(params)
    where_nearby(params)
    .where_latest
  end

  def self.where_ids(ids) 
    unless ids.nil?
      where(:id => ids)
    else
      scoped
    end
  end

  def self.where_nearby(params)
    location = params[:location]
    latitude = params[:latitude]
    longitude = params[:longitude]
    distance = params[:distance] || 1

    if latitude && longitude
      search_location = [latitude, longitude]
    elsif location
      search_location = location
    end

    if search_location
      Rails.logger.debug "Location detected " + search_location.to_s

      # near(search_location, distance)
      noise_ids = Origin.where_search(params).where_latest.all.map(&:noise_id)
      Rails.logger.debug "Found origins " + noise_ids.to_s
      where_ids(noise_ids)
    else
      scoped
    end
  end

  def self.where_latest
    where("#{table_name}.created_at >= ?", 12.hours.ago).order("#{table_name}.created_at DESC")
  end

  def self.where_has_coordinates
    where('longitude IS NOT NULL').where('latitude IS NOT NULL')
  end

  def self.where_since(user_id, noise_id)
    where(:user_id => user_id).
    where("#{table_name}.id < ?", noise_id)
  end

  def self.with_nearby_origins(params)
    joins(:origins)
      .preload(:origins)
      .merge(Origin.where_search(params))
  end

  def self.first_or_import_from_twitter_noise(twitter_noise, user) 
    where(:provider => Noise::PROVIDER_TWITTER, :provider_id => twitter_noise.id.to_s).first_or_create do |noise|
      noise.import_from_twitter_noise(twitter_noise, user)
    end
  end

end
