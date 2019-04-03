require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:sample_post) { FactoryBot.create(:post, title: Faker::String.random, description: Faker::String.random)}
  describe "#edit" do
    let(:user) { FactoryBot.create(:user, email: Faker::Internet.email, password: Faker::Internet.password)}
    let(:comment) { FactoryBot.create(:comment, message: Faker::String.random, post_id: sample_post.id, user_id: user.id)}
    context "When user is not logged in" do

      it "should redirect to the sign_in page" do
        get :edit, params: { id: comment.id, post_id: sample_post.id }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
      end
    end

    context "When user is logged in" do
      it "Should redirect to the edit page" do
        sign_in user
        get :edit, params: { id: comment.id, post_id: sample_post.id , user_id: user.id}
        expect(response).to render_template("comments/edit")
      end
    end
  end

  describe "#create" do
    let(:user) { FactoryBot.create(:user, email: Faker::Internet.email, password: Faker::Internet.password)}
    let(:comment_hash) {{ comment: {message: Faker::String.random }, post_id: sample_post.id }}
    context "When user is not logged in" do

      it "should redirect to the sign_in page" do
        post :create, params: comment_hash
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
      end
    end

    context "When user is logged in" do
      it "Should redirect to the show page of post" do
        sign_in user
        post :create, params: comment_hash
        expect(response).to redirect_to(post_url(Post.last.id))
        expect(flash[:notice]).to eq("Comment was successfully created.")
      end
    end

    context "When user is logged in and comment is not created" do
      it "Should render new page" do
        sign_in user
        allow_any_instance_of(Comment).to receive(:save).and_return(false)
        post :create, params: comment_hash
        expect(response).to render_template('comments/new')
      end
    end
  end

  describe "#update" do
    let(:user) { FactoryBot.create(:user, email: Faker::Internet.email, password: Faker::Internet.password)}
    let(:comment) {FactoryBot.create(:comment, message: Faker::String.random, post_id: sample_post.id, user_id: user.id) }
    let(:comment_hash) {{ comment: {message: Faker::String.random }, id: comment.id, post_id: sample_post.id }}
    context "When user is not logged in" do

      it "should redirect to the sign_in page" do
        patch :update, params: comment_hash
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
      end
    end

    context "When user is logged in" do
      it "Should redirect to the show page of post" do
        sign_in user
        patch :update, params: comment_hash
        expect(response).to redirect_to(post_url(comment_hash[:post_id]))
        expect(flash[:notice]).to eq("Comment was successfully updated.")
      end
    end

    context "When user is logged in and comment is not updated" do
      it "Should render new page" do
        sign_in user
        allow_any_instance_of(Comment).to receive(:update).and_return(false)
        patch :update, params: comment_hash
        expect(response).to render_template('comments/edit')
      end
    end
  end

  describe "#destroy" do
    let(:user) { FactoryBot.create(:user, email: Faker::Internet.email, password: Faker::Internet.password)}
    let(:comment) {FactoryBot.create(:comment, message: Faker::String.random, post_id: sample_post.id, user_id: user.id) }
    context "When user is not logged in" do

      it "should redirect to the sign_in page" do
        delete :destroy, params: { id: comment.id, post_id: sample_post.id }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
      end
    end

    context "When user is logged in" do
      let(:comment_hast) { {id: comment.id, post_id: sample_post.id, user_id: user.id }}
      it "Should redirect to the index page of post" do
        sign_in user
        delete :destroy, params: comment_hast
        expect(response).to redirect_to(post_url(id: sample_post.id))
        expect(flash[:notice]).to eq("Comment was successfully destroyed.")
      end
    end

  end

end
