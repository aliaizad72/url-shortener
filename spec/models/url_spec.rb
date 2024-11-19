require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe Url, type: :model do
  before do
    DatabaseCleaner.clean_with(:truncation)
    @url = Url.new(
      title: "Google",
      target: "https://www.google.com"
    )
  end

  it "has a base62_map method that maps an integer to a character" do
    expect(@url.base62_map(1)).to eq("1")
    expect(@url.base62_map(54)).to eq("s")
    expect(@url.base62_map(34)).to eq("Y")
  end

  it "has an to_base62 method transforms number from base 10 to base 62" do
    expect(@url.to_base62(30)).to eq("U")
    expect(@url.to_base62(20083)).to eq("5Dv")
    expect(@url.to_base62(3245678)).to eq("DcLe")
    expect(@url.to_base62(7983245)).to eq("XUo1")
  end

  it "after creation id was converted to base62 to be short link" do
    @url.save
    expect(@url.short).to eq("1")
  end
end
