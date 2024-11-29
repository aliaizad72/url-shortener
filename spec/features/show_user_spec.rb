require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe "on user show page", type: :feature do
  before do
    DatabaseCleaner.clean_with(:truncation)
    user = User.create(email: "test@dev.com", password: "12345678")
    user.urls.create(title: "aliaizad72", target: "https://github.com/aliaizad72")
  end

  scenario "click analytics logo" do
    visit new_user_session_path
    fill_in "email", with: "test@dev.com"
    fill_in "password", with: "12345678"
    click_on "log in"

    click_on "analytics"
    expect(page).to have_content("0 visits")
  end

  scenario "click delete logo" do
    visit new_user_session_path
    fill_in "email", with: "test@dev.com"
    fill_in "password", with: "12345678"
    click_on "log in"

    click_on "delete url"
    expect(page).to have_content("0 url")
  end
end
