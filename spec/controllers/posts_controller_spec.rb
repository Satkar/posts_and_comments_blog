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

  describe "#show" do
    context "When user is not logged in" do

      it "should redirect to the sign_in page" do
        get :show, params: { id: 'sfjhfsjfhksjfs' }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
      end
    end

    context "When user is logged in" do
      let(:user) { FactoryBot.create(:user, email: Faker::Internet.email, password: Faker::Internet.password)}
      let(:post) { FactoryBot.create(:post, title: Faker::String.random, description: Faker::String.random)}
      it "Should redirect to the show page" do
        sign_in user
        get :show, params: { id: post.id }
        expect(response).to render_template("posts/show")
      end
    end
  end

  describe "#edit" do
    context "When user is not logged in" do

      it "should redirect to the sign_in page" do
        get :edit, params: { id: 'sfjhfsjfhksjfs' }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
      end
    end

    context "When user is logged in" do
      let(:user) { FactoryBot.create(:user, email: Faker::Internet.email, password: Faker::Internet.password)}
      let(:post) { FactoryBot.create(:post, title: Faker::String.random, description: Faker::String.random)}
      it "Should redirect to the edit page" do
        sign_in user
        get :edit, params: { id: post.id }
        expect(response).to render_template("posts/edit")
      end
    end
  end

  describe "#create" do
    context "When user is not logged in" do

      it "should redirect to the sign_in page" do
        post :create, params: { title: 'sfjhfsjfhksjfs', description: 'sfsdfsfsdfsfsfsf' }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
      end
    end

    context "When user is logged in" do
      let(:user) { FactoryBot.create(:user, email: Faker::Internet.email, password: Faker::Internet.password)}
      let(:post_hast) { { post: { title: 'sfjhfsjfhksjfs', description: 'sfsdfsfsdfsfsfsf' } } }
      it "Should redirect to the show page of post" do
        sign_in user
        post :create, params: post_hast
        expect(response).to redirect_to(post_url(Post.last.id))
        expect(flash[:notice]).to eq("Post was successfully created.")
      end
    end

    context "When user is logged in and post is not created" do
      let(:user) { FactoryBot.create(:user, email: Faker::Internet.email, password: Faker::Internet.password)}
      let(:post_hast) { { post: { title: 'sfjhfsjfhksjfs', description: 'sfsdfsfsdfsfsfsf' } } }
      it "Should render new page" do
        sign_in user
        allow_any_instance_of(Post).to receive(:save).and_return(false)
        post :create, params: post_hast
        expect(response).to render_template('posts/new')
      end
    end
  end

  describe "#update" do
    let(:post) { FactoryBot.create(:post, title: Faker::String.random, description: Faker::String.random)}
    context "When user is not logged in" do

      it "should redirect to the sign_in page" do
        patch :update, params: { title: 'sfjhfsjfhksjfs', description: 'sfsdfsfsdfsfsfsf', id: post.id }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
      end
    end

    context "When user is logged in" do
      let(:user) { FactoryBot.create(:user, email: Faker::Internet.email, password: Faker::Internet.password)}
      let(:post_hast) { { post: { title: 'sfjhfsjfhksjfs', description: 'sfsdfsfsdfsfsfsf' }, id: post.id  }}
      it "Should redirect to the show page of post" do
        sign_in user
        patch :update, params: post_hast
        expect(response).to redirect_to(post_url(post_hast[:id]))
        expect(flash[:notice]).to eq("Post was successfully updated.")
      end
    end

    context "When user is logged in and post is not updated" do
      let(:user) { FactoryBot.create(:user, email: Faker::Internet.email, password: Faker::Internet.password)}
      let(:post_hast) { { post: { title: 'sfjhfsjfhksjfs', description: 'sfsdfsfsdfsfsfsf' } , id: post.id  }}
      it "Should render new page" do
        sign_in user
        allow_any_instance_of(Post).to receive(:update).and_return(false)
        patch :update, params: post_hast
        expect(response).to render_template('posts/edit')
      end
    end
  end

  describe "#destroy" do
    let(:post) { FactoryBot.create(:post, title: Faker::String.random, description: Faker::String.random)}
    context "When user is not logged in" do

      it "should redirect to the sign_in page" do
        delete :destroy, params: { id: post.id }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
      end
    end

    context "When user is logged in" do
      let(:user) { FactoryBot.create(:user, email: Faker::Internet.email, password: Faker::Internet.password)}
      let(:post_hast) { {id: post.id  }}
      it "Should redirect to the index page of post" do
        sign_in user
        delete :destroy, params: post_hast
        expect(response).to redirect_to(posts_url)
        expect(flash[:notice]).to eq("Post was successfully destroyed.")
      end
    end

  end

end
