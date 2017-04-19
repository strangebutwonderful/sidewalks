class Admin::OriginsController < Admin::AdminController

  # GET /origins
  def index
    @noise = Noise.find(params[:noise_id])
    @origins = @noise.origins

    respond_to do |format|
      format.html
    end
  end

  # GET /origins/1
  def show
    @noise = Noise.find(params[:noise_id])
    @origin = @noise.origins.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  # GET /origins/new
  def new
    @noise = Noise.find(params[:noise_id])
    @origin = Origin.new

    respond_to do |format|
      format.html
    end
  end

  # GET /origins/1/edit
  def edit
    @noise = Noise.find(params[:noise_id])
    @origin = @noise.origins.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  # POST /origins
  def create
    @noise = Noise.find(params[:noise_id])
    @origin = @noise.origins.build(origin_params)

    respond_to do |format|
      if @origin.save
        format.html do
          redirect_to(
            [:admin, @noise, @origin],
            notice: "Origin was successfully created."
          )
        end
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /origins/1
  def update
    @noise = Noise.find(params[:noise_id])
    @origin = @noise.origins.find(params[:id])

    if @origin.update_attributes(origin_params)
      flash[:notice] = "Noise origin was successfully updated."
    end

    respond_to do |format|
      if @origin.save
        format.html do
          redirect_to(
            [:admin, @noise, @origin],
            notice: "Origin was successfully updated.")
        end
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /origins/1
  def destroy
    @noise = Noise.find(params[:noise_id])
    @origin = @noise.origins.find(params[:id])
    @origin.destroy

    flash[:notice] = "Noise origin was successfully deleted."

    redirect_to [:admin, @noise, :origins]
  end

  private

  def origin_params
    params.require(:origin).permit(:latitude, :longitude)
  end
end
