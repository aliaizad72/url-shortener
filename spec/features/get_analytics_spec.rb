require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe "getting the url_visits page from visits/search", type: :feature do
  before do
    DatabaseCleaner.clean_with(:truncation)
    user = User.create(email: "test@dev.com", password: "12345678")
    user.urls.create(title: "Google", target: "https://google.com")
    Url.create(title: "aliaizad72", target: "https://github.com/aliaizad72")
  end

  scenario "user queried for analytics for non-user created url" do
    visit visits_search_path
    fill_in "url", with: "https://snippit.my/t2"
    click_on "get analytics"
    expect(page).to have_content("aliaizad72")
  end

  scenario "user queried for analytics for non-user created url" do
    visit visits_search_path
    fill_in "url", with: "https://snippit.my/t2"
    click_on "get analytics"
    expect(page).to have_content("aliaizad72")
  end

  scenario "user queried for analytics for other registered user created url" do
    visit visits_search_path
    fill_in "url", with: "https://snippit.my/t1"
    click_on "get analytics"
    expect(page).to have_content("Unauthorized access!")
  end

  scenario "user queried for analytics for other registered user created url" do
    visit new_user_session_path
    fill_in "email", with: "test@dev.com"
    fill_in "password", with: "12345678"
    click_on "log in"

    visit visits_search_path
    fill_in "url", with: "https://snippit.my/t1"
    click_on "get analytics"
    expect(page).to have_content("Google")
  end

  scenario "user queried for non-existent link" do
    visit visits_search_path
    fill_in "url", with: "https://snippit.my/t3"
    click_on "get analytics"
    expect(page).to have_content("No such links")
  end
end
