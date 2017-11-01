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
end
