class Admin::LocationsController < Admin::AdminController

  respond_to :html, :json

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
    @map = Map.new

    @locations.each do |location|
      @map.add_latlngs(location.latlng)
    end

    respond_with(:admin, @locations)
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    respond_with(:admin, @location)
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @location = Location.new
    @location.user_id = params[:user_id] unless params[:user_id].blank?

    respond_with(:admin, @location)
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])

    if @location.save
      flash[:notice] = "Location was successfully created"
    end

    respond_with(:admin, @location)
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    if @location.update_attributes(params[:location])
      flash[:notice] = 'Location was successfully updated.'
    end

    respond_with(:admin, @location)
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    flash[:notice] = 'Location was successfully deleted.'

    respond_with(:admin, @location)
  end
end
