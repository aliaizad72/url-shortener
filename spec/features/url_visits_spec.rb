require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe "visits index page", type: :feature do
  before do
    DatabaseCleaner.clean_with(:truncation)
    Url.create(title: "aliaizad72", target: "https://github.com/aliaizad72")
  end

  scenario "visits index page" do
    visit url_visits_path(1)
    expect(page).to have_content("aliaizad72")
  end
end
