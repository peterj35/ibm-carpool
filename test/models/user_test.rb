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

  test "associated offers should be destroyed" do
    @user.save
    @location.save
    @user.create_offer(location_id: @location.id, postal_code: "V2Y3B4")
    assert_difference 'Offer.count', -1 do
      @user.destroy
    end
  end
end
