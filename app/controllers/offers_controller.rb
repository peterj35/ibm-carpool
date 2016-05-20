class OffersController < ApplicationController
	before_action :logged_in_user, only: [:create, :edit, :destroy]

	def create
		@offer = current_user.create_offer(offer_params)
		if @offer.save
			flash[:success] = "Carpool Offer created!"
			redirect_to root_url
		else
			render 'static_pages/home'
		end
	end

	def edit
	end

	def destroy
	end

	private

		def offer_params
			params.require(:offer).permit(:brief, :work_start, :work_end, :flexible, :postal_code)
		end

end
