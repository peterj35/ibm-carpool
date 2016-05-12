class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_IBM_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.ibm\.com/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_IBM_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
