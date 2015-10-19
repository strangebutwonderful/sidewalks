class NoisesController < ApplicationController
  before_filter :disable_footer, only: [:explore]

  respond_to :html, :json

  # GET /noises
  # GET /noises.json
  def index
    @noise_funnel = NoiseFunnel.new(*explore_params)
    @map = Map.new(request_latlng, params)

    @noise_funnel.noises.each do |noise|
      @map.add_latlngs(noise.latlngs)
    end

    @noises = @noise_funnel.noise_grouped_by_user_id
    respond_with @noises
  end

  # GET /explore
  # GET /explore.json
  def explore
    @noise_funnel = NoiseFunnel.new(*explore_params)
    @map = Map.new(request_latlng, params)

    @noise_funnel.noises.each do |noise|
      @map.add_latlngs(noise.latlngs)
    end

    @noises = @noise_funnel.noise_grouped_by_user_id
    respond_with @noises
  end

  # GET /noises/1
  # GET /noises/1.json
  def show
    @noise = Noise.find(params[:id])
    @noises = Noise.where_authored_by_user_before(@noise.user_id, @noise.created_at)
      .limit(10)
      .joins(:user).preload(:user) # cuz nearby overrides includes
      .all

    respond_with @noise
  end

  private

  def explore_params
    [
      request_latitude,
      request_longitude,
      params[:distance] || 1.5,
      0.025,
      Time.current,
      7.days.ago
    ]
  end
end
