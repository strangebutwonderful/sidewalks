class SearchController < ApplicationController

  respond_to :html, :json

  # GET /search
  # GET /search.json
  def index
    @noises = Noise.search_text(params[:q]).where_since(1.week.ago)

    respond_with @noises
  end
end
