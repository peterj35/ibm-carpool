module OffersHelper

	# Returns true if the given user is the current user.
  def offer_owner?(user)
    user == offer_owner
  end

  # Returns the user corresponding to the remember token cookie.
  def offer_owner
    if (@offer = current_user.offer)
      @offer_owner ||= current_user
    end
  end

end
