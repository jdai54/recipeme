require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:my_user) { User.create!(email: "example@example.com", password: "password") }
  let(:my_topic) { Topic.create!(title: "tasty recipes", user: my_user) }
  let(:my_bookmark) { my_topic.bookmarks.create!(url: "www.tasty.com", user: my_user) }
  let(:my_like) { my_bookmark.like.create!(bookmark: my_bookmark, user: my_user) }

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_like] to @likes" do
      get :index
      expect(assigns(:likes)).to eq([my_like])
    end
  end

  describe "POST create" do
    it "redirects to the topics show view" do
      post :create, { bookmark_id: my_bookmark.id }
      expect(response).to redirect_to([my_topic, topic])
    end

    it "creates a like for the current user and the selected bookmark" do
      expect(my_user.likes.find_by_bookmark_id(my_bookmark.id)).to be_nil

      post :create, { bookmark_id: my_bookmark.id }

      expect(my_user.likes.find_by_bookmark_id(my_bookmark.id)).not_to be_nil
    end
  end

  describe "DELETE destroy" do
    it "redirects to the topics show view" do
      like = my_user.likes.where(bookmark: my_bookmark).create
      delete :destroy, { bookmark_id: my_bookmark.id, id: like.id }
      expect(response).to redirect_to([my_topic, topic])
    end

    it "destroys the like for the current user and post" do
      like = my_user.like.where(bookmark: my_bookmark).create
      expect( my_user.likes.find_by_bookmark_id(my_bookmark.id) ).not_to be_nil
      delete :destroy, { bookmark_id: my_bookmark.id, id: like.id }
      expect( my_user.likes.find_by_bookmark_id(my_bookmark.id) ).to be_nil
    end
  end
end
