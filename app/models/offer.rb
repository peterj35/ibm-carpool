class Offer < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  default_scope -> { order(updated_at: :desc) }
  validates :title, presence: true
  validates :user_id, presence: true
  validates :location_id, presence: true
  VALID_CANADIAN_POSTAL_CODE_REGEX = /\A[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1}[ -]?\d{1}[A-Z]{1}\d{1}\z/
  validates :postal_code, presence: true, format: { with: VALID_CANADIAN_POSTAL_CODE_REGEX }
  validates :brief, length: { maximum: 200 }
end
