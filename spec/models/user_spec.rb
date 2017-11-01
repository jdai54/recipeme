require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(email: "example@example.com", password: "password") }

  it{ is_expected.to have_many(:topics) }
  it{ is_expected.to have_many(:bookmarks) }
  it { is_expected.to have_many(:likes) }

  describe "#liked(bookmark)" do
    before do
      topic = Topic.create!(title: "tasty recipes", user: user)
      @bookmark = topic.bookmarks.create!(url: "www.tasty.com", user: user)
    end

    it "returns 'nil' if the user has not liked the bookmark" do
      expect(user.liked(@bookmark)).to be_nil
    end

    it "returns the appropriate like if it exists" do
      like = user.likes.where(bookmark: @bookmark).create
      expect(user.liked(@bookmark)).to eq(like)
    end
  end
end
