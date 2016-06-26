require 'openssl'
require 'ldap'
class User < ActiveRecord::Base
  has_one :offer, dependent: :destroy
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save		:downcase_email
	# before_create	:create_activation_digest
  validates :name, presence: true, length: { maximum: 50 }
  # VALID_IBM_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.ibm\.com/i
  validates :email, presence: true, length: { maximum: 255 },
                    # format: { with: VALID_IBM_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # has_secure_password
  # validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Begin LDAP Authentication to IBM Bluepages
  # The LDAP server to connect to
  LDAP_SERVER = 'bluepages.ibm.com'
  BASE_DN = 'ou=bluepages,o=ibm.com'

  # The attributes to retrieve and return after successful authentication
  # 'sn' = last name, 'mail' = email, 'givenName' = first name
  LDAP_ATTRIBUTES = ['sn','mail','givenName']

  # Wrapper function to perform authentication check for intranet login
  # username = Intranet e-mail address
  # password = IBM Intranet Password
  # Uses SSL for the entire connection.
  # Returns a hash of attributes if successful
  #         nil if unsuccessful
  # return example:
  #   {"sn"=>["ibmkanrsa"],
  #    "mail"=>["ibmkanrsa@ca.ibm.com", "kanrsa@ca.ibm.com"],
  #    "givenName"=>nil}
  def self.ldap_login(params)
    username = params[:email]
    password = params[:password]

    begin
      user_info = intranet_login(username, password)
    rescue LDAP::ResultError => e
      return nil
    end

    user = User.find_by(email: username.downcase)
    if user
      user
    else
      User.create(email: username.downcase,
                  name: get_name(user_info))
    end
  end

  # Returns name, based on what parameters are available in the Bluepages entry
  def self.get_name(user_info)
    first_name = user_info["givenName"][0] if user_info["givenName"]
    last_name = user_info["sn"][0] if user_info["sn"]

    if first_name and last_name
      "#{first_name} #{last_name}"
    elsif first_name
      first_name
    elsif last_name
      last_name
    else
      "John Doe"
    end
  end

  # Following LDAP Authentication taken from: 
  #   https://gist.github.com/lpar/5729836
  # Logs into the LDAP server, returns an array of attributes of the email
  def self.intranet_login(username, password)
    # First step is to look up the DN and other attributes
    ldap = LDAP::SSLConn.new(LDAP_SERVER, 636)
    dn = ""
    result = Hash.new
    succeeded = ldap.search_ext(BASE_DN, LDAP::LDAP_SCOPE_SUBTREE,
      "(&(objectClass=person)(mail=#{username}))") do |entry|
      # Got an entry, so store the attributes
      dn = entry.get_dn
      # Must copy the entry the hard way, as it's a C object
      for attr in LDAP_ATTRIBUTES
        result[attr] = entry[attr]
      end
    end
    if !succeeded or !dn
      return nil
    end
    # Now perform the actual auth check by binding with the dn and password
    ldap.unbind
    if ldap.bind(dn, password)
      return result
    else
      return nil
    end
  end


  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the db for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account.
  # def activate
  #   update_attribute(:activated,    true)
  #   update_attribute(:activated_at, Time.zone.now)
  # end

  # Sends activation email.
  # def send_activation_email
  #   UserMailer.account_activation(self).deliver_now
  # end

  # Sets the password reset attributes.
  # def create_reset_digest
  #   self.reset_token = User.new_token
  #   update_attribute(:reset_digest,  User.digest(reset_token))
  #   update_attribute(:reset_sent_at, Time.zone.now)
  # end

  # Sends password reset email.
  # def send_password_reset_email
  #   UserMailer.password_reset(self).deliver_now
  # end

  # Returns true if a password reset has expired.
  # def password_reset_expired?
  #   reset_sent_at < 2.hours.ago
  # end

	private

		# Converts email to all lower-case
		def downcase_email
			self.email = email.downcase
		end

		# Creates and assigns the activation token and digest
		# def create_activation_digest
		# 	self.activation_token 	= User.new_token
		# 	self.activation_digest	= User.digest(activation_token)
		# end
end
