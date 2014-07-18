class SearchController < ApplicationController

  respond_to :html, :json

  # GET /search
  # GET /search.json
  def index
    @noises = Noise.search(params).group_by do |noise|
      noise.user_id
    end

    respond_with @noises
  end
end
