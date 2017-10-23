require 'rails_helper'

describe "user visits the root page", :type => :feature do
  it "takes them to the user topics index page" do
    visit root_path
    expect(page).to have_content 'All Bookmarks'
  end
end

feature 'Create bookmark topics' do
  scenario 'can create a topic' do
    visit '/'
    fill_in('Enter new topic', with: 'Capybara')
    click_button 'Save'
    expect(page).to have_content('Capybara')
  end
end

feature 'Edit bookmark topic' do
  scenario 'can edit a topic' do
    visit '/'
    fill_in('Enter new topic', with: 'Capybara')
    click_button 'Save'
    fill_in('Enter new topic', with: 'Capybara')
    click_button 'Save'
    find(:xpath, "//a[contains(@href, 'topics/1/edit')]").click
    fill_in('Enter new topic', with: 'RSpec')
    click_button 'Save'
    expect(page).to have_content('RSpec')
  end
end

feature 'Deleting bookmark topics' do
  background do
    visit '/'
    fill_in('Enter new topic', with: 'Cats')
    click_button 'Save'
    visit '/'
  end
  scenario 'Can delete a single topic' do
    find(:id, "trash").click
    expect(page).to_not have_content('Cats')
  end
end

feature 'Create bookmark' do
  background do
    Topic.create(title: 'Cats')
  end
  scenario 'can create a bookmark' do
    visit '/'
    click_link 'Cats'
    fill_in('Enter a bookmark url', with: 'https://en.wikipedia.org/wiki/Cata')
    click_button 'Save'
    expect(page).to have_content('https://en.wikipedia.org/wiki/Cat')
  end
end

feature 'Edit bookmark' do
  background do
    my_topic = Topic.create!(title: "Cats")
    my_bookmark = my_topic.bookmarks.create!(url: "https://en.wikipedia.org/wiki/Cat")
  end
  scenario 'can edit a bookmark' do
    visit '/'
    click_link 'Cats'
    find(:xpath, "//a[contains(@href, 'topics/1/bookmarks/1/edit')]").click
    fill_in('Enter a bookmark url', with: 'http://www.animalplanet.com/pets/cats/')
    click_button 'Save'
    expect(page).to have_content('http://www.animalplanet.com/pets/cats/')
  end
end

feature 'Delete bookmark' do
  background do
    my_topic = Topic.create!(title: "Cats")
    my_bookmark = my_topic.bookmarks.create!(url: "https://en.wikipedia.org/wiki/Cat")
  end
  scenario 'can delete a bookmark' do
    visit '/'
    click_link 'Cats'
    find(:id, "trash").click
    expect(page).to_not have_content('https://en.wikipedia.org/wiki/Cat')
  end
end
