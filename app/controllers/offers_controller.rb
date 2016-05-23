class OffersController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :offer_owner,   only: [:edit, :update, :destroy]

	def new
		@offer = Offer.new
	end

	def create
		@offer = current_user.create_offer(offer_params)
		if @offer.save
			flash[:success] = "Carpool Offer created!"
			redirect_to @offer.user
		else
			render 'new'
		end
	end

	def edit
		@offer = Offer.find(params[:id])
	end

	def update
		@offer = Offer.find(params[:id])
		if @offer.update_attributes(offer_params)
			flash[:success] = "Offer Updated"
			redirect_to @offer.user
		else
			render 'edit'
		end
	end

	def destroy
		Offer.find(params[:id]).destroy
    flash[:success] = "Offer deleted"
    redirect_to request.referrer || root_url
	end

	private

		def offer_params
			params.require(:offer).permit(:title, :location_id, :brief, :work_start, 
																		:work_end, :flexible, :postal_code, :user_id)
		end

		def offer_owner
			@offer = current_user.offer
    	redirect_to root_url if @offer.nil?
  	end

end
