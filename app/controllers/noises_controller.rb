class NoisesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :nearby, :show]
  before_filter :import_noises, :only => [:index, :nearby]
  before_filter :save_current_user_last_trail, :only => [:index, :nearby]
  before_filter :verify_admin, :except => [:index, :nearby, :show]

  respond_to :html, :json

  # GET /noises
  # GET /noises.json
  def index
    @noises = Noise.where_search(params).all

    @noises = @noises.group_by do |noise|
      noise.user_id
    end

    respond_with @noises
  end

  # GET /noises/1
  # GET /noises/1.json
  def show
    @noise = Noise.find(params[:id])
    @noises = Noise.where_since(@noise.user_id, @noise.id)
      .where_latest
      .joins(:user).preload(:user) # cuz nearby overrides includes
      .all

    respond_with @noise
  end
end
