module OffersHelper

	# Returns true if the given user is the current user.
  def offer_owner?(user)
    user == offer_owner
  end

  # Returns the user corresponding to the remember token cookie.
  def offer_owner
    if (user_id = session[:user_id])
      @offer_owner ||= User.find_by(id: user_id)
    end
  end

end
