class LocationsController < ApplicationController
  
  def index
    @locations = Location.all
  end

  def show
  	@location = Location.find(params[:id])
  end

  def new
    @locations = Location.all
  	@location = Location.new
  end

  def create
  	@location = Location.new(location_params)
  	if @location.save
  	else
  		render 'new'
  	end
  end

  def manage
    @locations = Location.all
  end

  private

  	def location_params
  		params.require(:location).permit(:name)
  	end
end
