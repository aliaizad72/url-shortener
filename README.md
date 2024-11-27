# URL Shortener

To set up on your local machine, clone the repo and install the gems
```
bundle install
```
Dependencies:

 - Net gem -> to send HTTP requests: 
	 - to a target link provided by the user
	 - to BigDataCloud geolocation api to get the city and country based on a IP address  
 - Nokogiri gem -> to process the HTML return by the target link and get the title of the target link
 - recaptcha gem -> to add Google recaptcha v3 in the shortening url form
 - [BigDataCloud geolocation api](https://www.bigdatacloud.com/ip-geolocation) ->  to request information on city and country of people who send requests to the short link based on their IP address 
 - Devise gem -> which handles authentication and authorization for the User model
 - Pagy gem -> which scaffolds the pagination of urls and visits show pages

API Keys needed in Rails credentials:

 - Google reCapthcha keys
 - BigDataCloud api keys

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
 - 3.3.6

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

