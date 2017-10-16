require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:topic) { Topic.create!(name: "Tasty Recipes") }

  let(:bookmark) { topic.bookmark.create!(url: "www.tasty.com") }

  it { is_expected.to belong_to(:topic) }

  describe "attributes" do
    it "has a url attribute" do
      expect(bookmark).to have_attributes(url: "www.tasty.com")
    end
  end
end
