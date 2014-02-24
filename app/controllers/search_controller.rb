class SearchController < ApplicationController

  respond_to :html, :json

  # GET /search
  # GET /search.json
  def index
    @noises = Noise.search(params)

    respond_with @noises
  end
end
