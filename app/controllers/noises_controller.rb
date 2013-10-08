class NoisesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :import]
  before_filter :verify_admin, :except => [:index, :show, :import]

  # GET /noises
  # GET /noises.json
  def index
    @noises = Noise.order("created_at DESC").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @noises }
    end
  end

  # GET /noises/1
  # GET /noises/1.json
  def show
    @noise = Noise.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @noise }
    end
  end

  def import 
    TwitterNoiseImporter.import_latest_from_sidewalks_twitter

    redirect_to root_path
  end

  # GET /noises/1/edit
  def edit
    @noise = Noise.find(params[:id])
  end

  # PUT /noises/1
  # PUT /noises/1.json
  def update
    @noise = Noise.find(params[:id])

    respond_to do |format|
      if @noise.update_attributes(params[:noise])
        format.html { redirect_to @noise, notice: 'Noise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @noise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /noises/1
  # DELETE /noises/1.json
  def destroy
    @noise = Noise.find(params[:id])
    @noise.destroy

    respond_to do |format|
      format.html { redirect_to noises_url }
      format.json { head :no_content }
    end
  end
end
