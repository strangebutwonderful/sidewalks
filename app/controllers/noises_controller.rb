class NoisesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :nearby, :show]
  before_filter :save_current_user_last_trail, :only => [:index, :nearby]
  before_filter :verify_admin, :except => [:index, :nearby, :show]
  before_filter :override_request_geolocation, :only => [:index]

  respond_to :html, :json

  # GET /noises
  # GET /noises.json
  def index
    @noises = Noise.where_grouped_search(params)
    @map = Map.new(request_latlng, params)

    @noises.each do |user_id, noises|
      noises.each do |noise|
        @map.add_latlngs(noise.latlngs)
      end
    end

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
end
