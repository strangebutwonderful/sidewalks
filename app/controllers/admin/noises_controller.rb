class Admin::NoisesController < Admin::AdminController

  respond_to :html, :json

  # GET /noises
  # GET /noises.json
  def index
    @noises = Noise.where_search(params).all

    respond_with(:admin, @noises)
  end

  # GET /noises/1
  # GET /noises/1.json
  def show
    @noise = Noise.find(params[:id])

    respond_with(:admin, @noise)
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

    respond_with(:admin, @noise)
  end

  # DELETE /noises/1
  # DELETE /noises/1.json
  def destroy
    @noise = Noise.find(params[:id])
    @noise.destroy

    flash[:notice] = 'Noise was successfully deleted.'

    respond_with(:admin, @noise)
  end
end
