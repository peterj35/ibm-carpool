class OffersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :offer_owner,   only: [:edit, :update, :destroy]

  def new
    @user = current_user
    if @user.offer.present?
      flash[:info] = "You already have an offer. You can edit it, or update your offer."
      redirect_to @user
    end
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
      params.require(:offer).permit(:title, :location_id, :brief, :flexible, :postal_code, :user_id, :specific_location)
    end

    def offer_owner
      @offer = Offer.find(params[:id])
      redirect_to root_url if @offer.nil? || @offer.user_id != current_user.id
    end

end
