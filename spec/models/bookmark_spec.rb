require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:user) { User.create!(email: "example@example.com", password: "password") }
  let(:topic) { Topic.create!(title: "Tasty Recipes", user: user) }
  let(:bookmark) { topic.bookmarks.create!(url: "www.tasty.com", user: user) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:topic) }

  describe "attributes" do
    it "has url and user attributes" do
      expect(bookmark).to have_attributes(url: "www.tasty.com", user: user)
    end
  end
end
