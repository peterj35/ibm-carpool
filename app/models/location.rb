class Location < ActiveRecord::Base
	has_many :offers, dependent: :destroy
	validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
end
