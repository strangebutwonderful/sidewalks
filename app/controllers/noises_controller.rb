class NoisesController < ApplicationController
  before_action :disable_footer, only: [:explore]

  # GET /noises
  def index
    @noise_funnel = NoiseFunnel.new(*explore_params)
    @noises = @noise_funnel.noise_grouped_by_user_id

    respond_to do |format|
      format.html
    end
  end

  # GET /explore
  def explore
    @noise_funnel = NoiseFunnel.new(*explore_params)
    @map = Map.new(request_lat_lng, params)

    @noise_funnel.noises.each do |noise|
      @map.add_lat_lngs(noise.lat_lngs)
    end

    @noises = @noise_funnel.noise_grouped_by_user_id

    respond_to do |format|
      format.html
    end
  end

  # GET /noises/1
  def show
    @noise = Noise.find(params[:id])
    @noises = Noise.where_authored_by_user_before(@noise.user_id, @noise.created_at).
              limit(10).
              joins(:user).preload(:user). # cuz nearby overrides includes
              all

    respond_to do |format|
      format.html
    end
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
