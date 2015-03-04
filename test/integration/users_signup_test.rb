require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	def setup
		@user = User.new
	end

	test "Valid signup information" do
		get signup_path

		assert_difference 'User.count', 1 do
			post_via_redirect users_path, user: { name: "Example User",
									email: "user@example.com",
									password: "password",
									password_confirmation: "password"}
		end
		assert_template 'users/show'
		assert_not flash.nil?
	end

	test "Invalid signup information" do
  		get signup_path

  		assert_no_difference 'User.count' do 
  			post users_path, user: { name: "",
									email: "user@invalid",
									password: "foo",
									password_confirmation: "bar"}
  		end
  		assert_template 'users/new'
  		assert_select 'div#<error-explanation>'
  		assert_select 'div.<alert alert-danger>'
  		assert_not @user.errors.count.nil?
  	end
end
