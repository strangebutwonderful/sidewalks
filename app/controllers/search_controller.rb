class SearchController < ApplicationController

  # GET /search
  def index
    @noises = Noise.search(params).group_by(&:user_id)

    respond_to do |format|
      format.html
    end
  end
end
