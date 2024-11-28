require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe "creating short url", type: :feature do
  before do
    DatabaseCleaner.clean_with(:truncation)
  end

  scenario "valid inputs" do
    visit new_url_path
    fill_in "url_target", with: "https://www.theodinproject.com"
    click_on "shorten url"
    visit preview_url_path(1)
    expect(page).to have_content("snippit.my/t1")
  end

  scenario "invalid inputs, url dont exist" do
    visit new_url_path
    fill_in "url_target", with: "https://www.theoroject.cm"
    click_on "shorten url"
    expect(page).to have_content("Failed to open")
  end

  scenario "invalid inputs, 403 Forbidden" do
    visit new_url_path
    fill_in "url_target", with: "https://www.coingecko.com"
    click_on "shorten url"
    expect(page).to have_content("Forbidden")
  end
end