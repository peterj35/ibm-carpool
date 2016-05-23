require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@ca.ibm.com",
                      password: "foobar", password_confirmation: "foobar")
    @location = Location.new(name: "8200 Foo")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should exist" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "email should exist" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid IBM addresses" do
    valid_addresses = %w[user4@ca.ibm.com USER@us.ibm.com 
                          jap_an@jp.ibm.com M+ex3@mx.ibm.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid and NON-IBM addresses" do
    invalid_addresses = %w[user@example.com user_at_foo.org user.name@example.
                            comma@example,com foo@ca_ibm.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  # Todo : make this test working
  # test "associated offers should be destroyed" do
  #   @user.save
  #   @location.save
  #   @user.create_offer(location_id: @location.id, postal_code: "V2Y3B4")
  #   assert_difference 'Offer.count', -1 do
  #     @user.destroy
  #   end
  # end
end
