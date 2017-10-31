require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:user) { User.create!(email: "example@example.com", password: "password") }
  let(:topic) { Topic.create!(title: "tasty recipes", user: user) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:bookmarks) }

  describe "attributes" do
    it "has a title and user attributes" do
      expect(topic).to have_attributes(title: "tasty recipes", user: user)
    end
  end
end
