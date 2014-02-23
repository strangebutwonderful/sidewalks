class SearchController < ApplicationController

  respond_to :html, :json

  # GET /search
  # GET /search.json
  def index
    @noises = Noise.advanced_search(:text => params[:q])

    respond_with @noises
  end
end
