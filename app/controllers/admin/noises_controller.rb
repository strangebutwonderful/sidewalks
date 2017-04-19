class Admin::NoisesController < Admin::AdminController

  # GET /noises
  def index
    @noises = Noise.order(created_at: :desc).limit(50).all

    respond_to do |format|
      format.html
    end
  end

  # GET /noises/triage
  def triage
    @noises = Noise.where_needs_triage.limit(50).all

    respond_to do |format|
      format.html { render :index }
    end
  end

  # GET /noises/1
  def show
    @noise = Noise.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  # GET /noises/1/edit
  def edit
    @noise = Noise.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  # PUT /noises/1
  def update
    @noise = Noise.find(params[:id])

    @noise.attributes = noise_params

    respond_to do |format|
      @noise.save!

      format.html do
        redirect_to(
          [:admin, @noise],
          notice: "Noise was successfully updated."
        )
      end
    end
  end

  # DELETE /noises/1
  def destroy
    @noise = Noise.find(params[:id])
    @noise.destroy

    flash[:notice] = "Noise was successfully deleted."

    redirect_to action: :index
  end

  private

  def noise_params
    params.require(:noise).permit(:actionable)
  end
end
