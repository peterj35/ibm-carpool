class LocationsController < ApplicationController
  before_action :logged_in_admin_user,     only: [:manage, :new, :edit, :update, :destroy]
  
  def index
    @locations = Location.all
  end

  def show
  	@location = Location.find(params[:id])
		@user = User.find(params[:id])
		@offers = @location.offers.paginate(page: params[:page])
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

	def edit
		@location = Location.find(params[:id])
	end

	def update
		@location = Location.find(params[:id])
		if @location.update_attributes(location_params)
			flash[:success] = "Location Updated"
			redirect_to manage_locations_path
		else
			render 'edit'
		end
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
			if !logged_in?
				flash[:danger] = "Please log in."
				redirect_to(root_url)
			else
				flash[:danger] = "No access"
      	redirect_to(root_url) unless current_user.admin?
    	end
		end
end
