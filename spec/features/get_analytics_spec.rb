require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe "getting the url_visits page from visits/search", type: :feature do
  before do
    DatabaseCleaner.clean_with(:truncation)
    user = User.create(email: "test@dev.com", password: "12345678")
    user.urls.create(title: "Google", target: "https://google.com")
    Url.create(title: "aliaizad72", target: "https://github.com/aliaizad72")
  end

  # scenario "user queried for analytics for non-user created url" do
  #   visit preview_url_path(2)
  #   url = find(:id, "url")
  #   fill_in "url", with: "https://snippit.my/t2"
  #   # click_on "get analytics"
  # end
end
