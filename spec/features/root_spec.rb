require 'rails_helper'

describe "user visits the root page", :type => :feature do
  it "takes them to the user topics index page" do
    visit root_path
    expect(page).to have_content 'All Bookmarks'
  end
end
