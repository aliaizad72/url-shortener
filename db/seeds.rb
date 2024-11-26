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

fake_ips = %w[103.229.232.255 103.21.155.255 101.32.175.255 103.103.139.255 203.0.113.21]
fake_visits = fake_ips.map do |ip|
  {
    request_time: Time.new
  }.merge(UrlsController.new.send(:get_location, ip))
end

url.visits.create(fake_visits)


