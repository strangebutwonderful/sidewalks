class SearchController < ApplicationController

  respond_to :html, :json

  # GET /search
  # GET /search.json
  def index
    @noises = Noise.fuzzy_search(params[:q]).all
  end
end
