require 'rails_helper'

RSpec.describe "UrlsControllers", type: :request do
  it "get_location return hashmap of request location from IP" do
    ip = "2001:f40:950:d936:f527:b5ff:5002:a90d"
    result = UrlsController.new.send(:get_location, ip)
    expected = {
      city: "Petaling",
      country: "Malaysia"
    }
    expect(result).to eql(expected)
  end
end
