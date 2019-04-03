require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "#index" do
  	context "When user is not logged in" do

      it "should redirect to the sign_in page" do
  			get :index
  			expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
  		end
  	end
    context "When user is logged in" do
      let(:user) { FactoryBot.create(:user, email: Faker::Internet.email, password: Faker::Internet.password)}
      it "Should redirect to the index page" do
        sign_in user
        get :index
        expect(response).to render_template("posts/index")
      end
    end
  end

end
