class LocationsController < ApplicationController
  before_action :logged_in_admin_user,     only: [:manage, :new, :destroy]
  
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
      flash[:success] = "Location has been added."
      redirect_to locations_url
  	else
  		render 'new'
  	end
  end

  def manage
    @locations = Location.all
  end

  def destroy
    Location.find(params[:id]).destroy
    flash[:success] = "Location deleted"
    redirect_to manage_locations_path
  end

  private

  	def location_params
  		params.require(:location).permit(:name)
  	end

    # Confirms a logged in, admin user.
    def logged_in_admin_user
      redirect_to(root_url) unless logged_in?
      redirect_to(root_url) unless current_user.admin?
    end
end
