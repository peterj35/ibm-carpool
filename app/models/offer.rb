class Offer < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  default_scope -> { order(updated_at: :desc) }
  validates :title, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :location_id, presence: true
  VALID_CANADIAN_POSTAL_CODE_REGEX = /\A[ABCEGHJKLMNPRSTVXYabcdefghjklmnprstvxy]{1}\d{1}[a-zA-Z]{1}[ -]?\d{1}[a-zA-Z]{1}\d{1}\z/
  validates :postal_code, presence: true, format: { with: VALID_CANADIAN_POSTAL_CODE_REGEX }
  validates :brief, length: { maximum: 600 }
  before_save :clean_postal

  def clean_postal
  	if postal_code.length == 6
  		# TODO: this doesn't clean properly for some reason...
  		self.postal_code.gsub(/(.{3})/, '\1 ')
  	end
  	self.postal_code.upcase!
  end
end
