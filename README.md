# snippit: a url-shortener

A web application that takes your very very long link and shorten it. 

Deployment link: https://www.snippit.my

## Main Feature

[snippit.my](https://www.snippit.my) is a web application that takes in a target URL and transforms it into a shorter URL for your own use (common use case is in marketing). The application takes in your target URL and stores it in a database. A unique key is produced and assigned to the target URL in the process of storing the target URL to the database. Whenever a request is made to [snippit.my](https://www.snippit.my) with a parameter *key* such as [snippit.my/tA1](), the user is simply rerouted to the target URL paired with the key, in this case *key: 1*.
 
## Other Features

 - Every shortened URL have an analytics page that provides information of visitors of the shortened URL. The metrics provided are IP address, city, and country of the visitor and the time the visit occured.
 - This data can be downloaded as a compressed CSV file by the users should they want to do further data analysis on them.
 - Registered users can track the links that they have shortened previously.

## How the Features Are Implemented

### Scraping the Title from the Target URL

 [`net-http`](https://rubygems.org/gems/net-http/versions/0.4.1?locale=en) gem is used to send an HTTP request to the target URL, and the HTML response is parsed by the [`nokogiri`](https://rubygems.org/gems/nokogiri) gem to grab the title of the URL.
 
### Securing the Create Short URL Form from Spam

  [Google reCaptcha v2](https://www.google.com/recaptcha/about/) is scaffolded using the [`recaptcha`](https://github.com/ambethia/recaptcha) gem to protect the form from spam. 

### Producing the Short URL

 After the target URL is saved in the database, the `Url` model takes the id of that instance and convert it to a base62 number. For example, a `Url` instance of id: `123123` will return  `W1r`. It would take more than 56 billion urls before the key would exceed 6 characters (last key: `zzzzzz`). 

This `Url` instance is then updated with this key and return to the user the short URL of [snippit.my/tWir](). The letter "t" is prepended to the key as a marker in routes to point it at the `redirect` action that would occur if someone makes a request at the short URL.

### Redirecting the Short URL

When a client requests with parameters key, e.g. [snippit.my/t**2**](https://snippit.my/t2), the routes will point to a `redirect` action in the controller. A `Url` instance is queried from the database based on the key (2) and a `Visit` instance will be created as part of that process. Lastly, the client is redirected to the target URL that was created earlier.

### URL Analytics

As mentioned before, a `Visit` instance is created every time a client requests a `redirect` via the short link. The `Visit` model's attributes consist of IP address, city, country and time of request.

In the `redirect` controller action, the IP address of the client is acquired with `request.remote_ip`. The geolocation data of the controller is obtained externally via [BigDataCloud Geolocation API](https://www.bigdatacloud.com/ip-geolocation/ip-address-geolocation-api) with the [`net-http`](https://rubygems.org/gems/net-http) gem and the respective IP addresses of clients. On successful query, the city and country attributes are extracted from the response. In the case where IP address are valid, but response does not contain city and country, the city and country attributes will be assigned "NA". Time of request is the time when the `redirect` controller action begins.

### Downloadable Compressed CSV URL Analytics Report

When a user clicks the download link, the `download` controller action begins by finding the collection of `Visits` associated with the URL. This collection is then transformed into a CSV string using the [`csv`](https://rubygems.org/gems/csv) gem. The [`rubyzip`](https://rubygems.org/gems/rubyzip) gem, more specifically the  `Zip::OutputStream.write_buffer` method , is used to open a data stream and write the CSV string into a compressed filestream. Once the CSV is written into the filestream, the filestream is rewound so it can be read. Finally, the filestream is sent to the client as a downloadable file using Rails' `send_data`.
   
### Tracking User Created Short URLs

`devise` gem is used to scaffold authentication and authorization. Registered `Users` can track and untrack their `Url` instances. The analytics page and CSV file is only available to the `User` that created the `Url` instance, others are prohibited to access those pages and files.

## Local Development

### Dependencies

* Ruby version 3.3.6
* Ruby on Rails 8.0.0
* PostgresSQL
* TailwindCSS 
* [`nokogiri`](https://rubygems.org/gems/nokogiri) gem
* [`recaptcha`](https://github.com/ambethia/recaptcha) gem
* [`rubyzip`](https://rubygems.org/gems/rubyzip) gem
* [`devise`](https://rubygems.org/gems/devise) gem
* [`pagy`](https://rubygems.org/gems/pagy) gem - for index pagination

### Installing

* Make sure you have the correct version of Ruby (3.3.6)
* Get your API keys for [BigDataCloud Geolocation API](https://www.bigdatacloud.com/ip-geolocation/ip-address-geolocation-api) and [Google reCaptcha v2](https://www.google.com/recaptcha/about/)
* Save the API keys in Rails credentials or .env
* Refer to [`recaptcha`](https://github.com/ambethia/recaptcha) gem docs for the implementation
* Clone this repo and run:
```
bundle install
```
* Create and migrate database:
```
rails db:create && rails db:migrate
```

### Run server
```
./bin/dev
```
## Testing
Helper methods in controllers and models, such as transforming base10 numbers to base62, and fetching geolocation are unit tested using [`rspec-rails`](https://rubygems.org/gems/rspec-rails) gem. 

Run this command at root to run test suite:

```
rspec
```

Integration tests are still in the process of being written with  [`rspec-rails`](https://rubygems.org/gems/rspec-rails) gem and  [`capybara`](https://rubygems.org/gems/capybara) gem.

## Deployment

[snippit.my](https://snippit.my) is deployed on [fly.io](https://fly.io/). 

IMPORTANT: your host may present multiple IP addresses to your app, and when requesting geolocation of your client you may query using your hosts IP addresses instead. To solve this, add IP addresses used by your host to ` config.action_dispatch.trusted_proxies` in `production.rb`. This will avoid the `request.remote_ip` in `urls#redirect` to consider your hosts' IP addresses as "remote".

