class Computer < ActiveRecord::Base
	# Relations
	belongs_to :user

	# Validators
	validates :user_id, presence: true

	# Methods
	

end
