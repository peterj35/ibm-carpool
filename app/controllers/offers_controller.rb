class OffersController < ApplicationController
	before_action :logged_in_user, only: [:new]
	before_action :logged_in_admin_user, only: [:destroy]
	before_action :correct_user,   only: [:edit, :update, :destroy]

	def new
		@offer = Offer.new
	end

	def create
		@offer = current_user.create_offer(offer_params)
		if @offer.save
			flash[:success] = "Carpool Offer created!"
			redirect_to locations_path
		else
			render 'new'
		end
	end

	def edit
	end

	def destroy
	end

	private

		def offer_params
			params.require(:offer).permit(:title, :location_id, :brief, :work_start, :work_end, :flexible, :postal_code)
		end

end
