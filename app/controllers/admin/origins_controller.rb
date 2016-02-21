class Admin::OriginsController < Admin::AdminController
  respond_to :html, :json

  # GET /origins
  # GET /origins.json
  def index
    @noise = Noise.find(params[:noise_id])
    @origins = @noise.origins

    respond_with(:admin, @noises, @origins)
  end

  # GET /origins/1
  # GET /origins/1.json
  def show
    @noise = Noise.find(params[:noise_id])
    @origin = @noise.origins.find(params[:id])

    respond_with(:admin, @noises, @origin)
  end

  # GET /origins/new
  # GET /origins/new.json
  def new
    @noise = Noise.find(params[:noise_id])
    @origin = Origin.new

    respond_with(:admin, @noises, @origin)
  end

  # GET /origins/1/edit
  def edit
    @noise = Noise.find(params[:noise_id])
    @origin = @noise.origins.find(params[:id])
  end

  # POST /origins
  # POST /origins.json
  def create
    @noise = Noise.find(params[:noise_id])
    @origin = @noise.origins.build(origin_params)

    flash[:notice] = "Location was successfully created." if @origin.save

    respond_with(:admin, @noise, @origin)
  end

  # PUT /origins/1
  # PUT /origins/1.json
  def update
    @noise = Noise.find(params[:noise_id])
    @origin = @noise.origins.find(params[:id])

    if @origin.update_attributes(origin_params)
      flash[:notice] = "Noise location was successfully updated."
    end

    respond_with(:admin, @noise, @origin)
  end

  # DELETE /origins/1
  # DELETE /origins/1.json
  def destroy
    @noise = Noise.find(params[:noise_id])
    @origin = @noise.origins.find(params[:id])
    @origin.destroy

    flash[:notice] = "Noise Location was successfully deleted."

    respond_with(:admin, @noise, @origin)
  end

  private

  def origin_params
    params.require(:origin).permit(:latitude, :longitude)
  end
end
