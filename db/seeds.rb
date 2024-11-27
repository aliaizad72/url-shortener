# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create(email: "test@dev.com", password: "12345678")
user2 = User.create(email: "ali@dev.com", password: "12345678")
user.urls.create([{target: "https://github.com/aliaizad72", title: "aliaizad72"}])

url = user.urls.first

ips = %w[103.229.232.255 103.21.155.255 101.32.175.255 103.103.139.255 203.0.113.21 2001:f40:950:d936:69f8:bdbd:5951:6233 2001:f40:950:d936:9b91:2de:332b:ccd0 7.54.255.254 7.139.255.254 84.10.255.254 84.57.255.254 118.4.255.254 118.43.255.254 62.12.255.254 62.55.255.254 143.7.255.254 177.20.255.254 177.43.255.254]
fake_ips = []
15.times do |i|
  fake_ips += ips
end

fake_visits = fake_ips.map do |ip|
  {
    ip: ip,
    request_time: Time.new
  }.merge(UrlsController.new.send(:get_location, ip))
end

url.visits.create(fake_visits)


