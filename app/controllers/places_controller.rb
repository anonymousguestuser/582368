class PlacesController < ApplicationController
  before_action :set_id, only:[:show]
  def index
  end

  def show
    @place = BeermappingApi.get(@id)
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  private
  def set_id
    @id = params[:id]
  end

end