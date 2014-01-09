class OriginsController < ApplicationController

  respond_to :html, :json

  # GET /origins
  # GET /origins.json
  def index
    @origins = Origin.where_search(params).all

    respond_with @origins
  end

  # GET /origins/1
  # GET /origins/1.json
  def show
    @origin = Origin.find(params[:id])
    @noises = Noise.where_since(@origin.noise.user_id, @origin.noise.id)
      .where_latest
      .joins(:user).preload(:user) # cuz nearby overrides includes
      .all

    respond_with @origin
  end

end