class NoisesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :nearby, :show]
  before_filter :verify_admin, :except => [:index, :nearby, :show]
  before_filter :import_noises, :only => [:index, :nearby]

  respond_to :html, :json

  # GET /noises
  # GET /noises.json
  def index
    @noises = Noise.where_latest.where_search(params)
      .joins(:user).preload(:user) # cuz nearby overrides includes
      .all

    respond_with @noises
  end

  # GET /noises/1
  # GET /noises/1.json
  def show
    @noise = Noise.find(params[:id])

    respond_with @noise
  end

  # GET /noises/1/edit
  def edit
    @noise = Noise.find(params[:id])
  end

  # PUT /noises/1
  # PUT /noises/1.json
  def update
    @noise = Noise.find(params[:id])

    if @noise.update_attributes(params[:noise])
      flash[:notice] = 'Noise was successfully updated.'
    end

    respond_with @noise
  end

  # DELETE /noises/1
  # DELETE /noises/1.json
  def destroy
    @noise = Noise.find(params[:id])
    @noise.destroy

    flash[:notice] = 'Noise was successfully deleted.'

    respond_with @noise
  end
end
