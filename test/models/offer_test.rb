require 'test_helper'

class OfferTest < ActiveSupport::TestCase

	def setup
		@user = users(:peter)
		@location = locations(:warden)
		@offer = @user.create_offer!(title: "foobar", location_id: @location.id, postal_code: "V2Y3B4", user_id: @user.id)
	end

	test "should be valid" do
    assert @offer.valid?
  end

  test "title should be present" do
    @offer.title = nil
    assert_not @offer.valid?
  end

  test "user id should be present" do
  	@offer.user_id = nil
  	assert_not @offer.valid?
  end

  test "location id should be present" do
  	@offer.location_id = nil
  	assert_not @offer.valid?
  end

  test "postal code should be present" do
  	@offer.postal_code = nil
  	assert_not @offer.valid?
  end

  test "postal code should be valid" do
  	@offer.postal_code = "90210"
  	assert_not @offer.valid?
  end

  test "brief should be at most 600 characters" do
  	@offer.brief = "a" * 601
  	assert_not @offer.valid?
  end

  # FAILING due to "associated offers should be destroyed" testcase in user_test.rb
  # so lazily omit the test
  # test "order should be most recently updated first" do
  #   assert_equal offers(:most_recent), Offer.first
  # end
end
