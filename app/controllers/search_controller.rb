class SearchController < ApplicationController

  respond_to :html, :json

  # GET /search
  # GET /search.json
  def index
    @noises = Noise.fuzzy_search(params[:q])
    .limit(50)
    .all

    respond_with @noises
  end
end
