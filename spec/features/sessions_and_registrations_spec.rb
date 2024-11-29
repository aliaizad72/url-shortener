require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe "sign in / sign up", type: :feature do
  before do
    DatabaseCleaner.clean_with(:truncation)
  end

  scenario "create new account" do
    visit new_user_registration_path
    fill_in "email", with: "test@dev.com"
    fill_in "user_password", with: "12345678"
    fill_in "user_password_confirmation", with: "12345678"
    click_on "sign up"
    expect(page).to have_content("0 urls")
    click_on "log out"
  end

  scenario "create new account" do
    User.create(email: "test@dev.com", password: "12345678")
    visit new_user_session_path
    fill_in "email", with: "test@dev.com"
    fill_in "user_password", with: "12345678"
    click_on "log in"
    expect(page).to have_content("0 urls")
  end
end
