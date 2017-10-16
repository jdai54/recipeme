require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { Topic.create!(title: "tasty recipes") }

  it { is_expected.to have_many(:bookmarks) }

  describe "attributes" do
    it "has a title attribute" do
      expect(topic).to have_attributes(title: "tasty recipes")
    end
  end
end
