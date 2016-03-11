require "spec_helper"
require "rails_helper"

describe LoginController do
	describe "logging in a user" do
		it "should redirect a user to the user page if user exists" do
			user = User.create(first_name: "John", last_name: "Doe",
							uid: "1111111", email: "john@doe.com")
			get(:index, nil, {:cas_user => "1111111"})
			expect(response).to redirect_to '/user'
		end

		it "should open login page if user doesn't exist" do
			get(:index, nil, {:cas_user => "whatever"})
			expect(response).to render_template(:layout => "login")
		end
	end
end
