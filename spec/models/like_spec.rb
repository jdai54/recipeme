require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create!(email: "example@example.com", password: "password") }
  let(:topic) { Topic.create!(title: "tasty recipes", user: user) }
  let(:bookmark) { topic.bookmark.create!(url: "www.tasty.com", user: user) }
  let(:like) { Like.create!(bookmark: bookmark, user: user) }

  it{ is_expected.to belong_to(:user) }
  it{ is_expected.to belong_to(:bookmark) }
end
