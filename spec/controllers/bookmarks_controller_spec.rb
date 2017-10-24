require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do

  let(:my_topic) {Topic.create!(title: "Food")}
  let(:my_bookmark) {my_topic.bookmarks.create!(url: "www.maanchi.com")}

  describe "POST create" do
    it "increases the number of Bookmark by 1" do
      expect{post :create, topic_id: my_topic.id, bookmark: {url: "www.maangchi.com"}}.to change(Bookmark,:count).by(1)
    end

    it "assigns the new bookmark to @bookmark" do
      post :create, topic_id: my_topic.id, bookmark: {url: "www.maangchi.com"}
      expect(assigns(:bookmark)).to eq Bookmark.last
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_bookmark.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, topic_id: my_topic.id, id: my_bookmark.id
      expect(response).to render_template :edit
    end

    it "assigns bookmark to be updated to @bookmark" do
      get :edit, topic_id: my_topic.id, id: my_bookmark.id

      bookmark_instance = assigns(:bookmark)

      expect(bookmark_instance.id).to eq my_bookmark.id
      expect(bookmark_instance.url).to eq my_bookmark.url
    end
  end

  describe "PUT update" do
    it "updates bookmark with expected attributes" do
      new_url = "www.food52.com"

      put :update, topic_id: my_topic.id, id: my_bookmark.id, bookmark: {url: "www.food52.com"}

      updated_bookmark = assigns(:bookmark)
      expect(updated_bookmark.id).to eq my_bookmark.id
      expect(updated_bookmark.url).to eq new_url
    end

    it "redirects to the root page" do
      new_url = "www.food52.com"

      put :update, topic_id: my_topic.id, id: my_bookmark.id, bookmark: {url: "www.food52.com"}
      expect(response).to redirect_to root_path
    end
  end

  describe "DELETE destroy" do
    it "deletes the bookmark" do
      delete :destroy, topic_id: my_topic.id, id: my_bookmark.id
      count = Bookmark.where({id: my_bookmark.id}).size
      expect(count).to eq 0
    end
  end
end
