class Admin::LocationsController < Admin::AdminController

  # GET /locations
  def index
    @locations = Location.all
    @map = Map.new

    @locations.each do |location|
      @map.add_lat_lngs(location.lat_lng)
    end

    respond_to do |format|
      format.html
    end
  end

  # GET /locations/1
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  # GET /locations/new
  def new
    @location = Location.new
    @location.user_id = params[:user_id] unless params[:user_id].blank?

    respond_to do |format|
      format.html
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    @location.geocode

    respond_to do |format|
      if @location.save
        format.html do
          redirect_to(
            [:admin, @location],
            notice: "Location was successfully created."
          )
        end
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /locations/1
  def update
    @location = Location.find(params[:id])

    @location.attributes = location_params

    @location.geocode if @location.geography_changed?

    respond_to do |format|
      if @location.save
        format.html do
          redirect_to(
            [:admin, @location],
            notice: "Location was successfully updated."
          )
        end
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /locations/1
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    flash[:notice] = "Location was successfully deleted."

    redirect_to action: :index
  end

  private

  def location_params
    params.require(:location).permit(:user_id, :address, :city, :latitude, :longitude, :state, :zip)
  end
end
