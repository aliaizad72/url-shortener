class UrlsController < ApplicationController
  def new
    @url = Url.new
  end
  def create
    target = params[:url][:target]
    begin
      response = fetch(target)
      title = Nokogiri::HTML(response.body).title
      title = "Title tag not available" if title.nil?

      @url = Url.new(target: target, title: title)

      if verify_recaptcha(model: @url) && @url.save
        if current_user
          current_user.urls << @url
        end

        redirect_to preview_url_path(@url)
      else
        flash[:alert] = "Shortening process failed"
        redirect_to root_path
      end
    rescue Exception => e
      flash[:alert] = "#{e}"
      redirect_back_or_to root_path
    end
  end

  def preview
    @new_url = Url.new
    @url = Url.find(params[:id])
  end
  def redirect
    request_time = Time.new
    ip = request.remote_ip
    location = get_location(ip)

    @url = Url.find_by(short: params[:short])
    @url.visits.create(ip: ip, request_time: request_time, city: location[:city], country: location[:country])
    redirect_to(@url.target, allow_other_host: true)
  end

  def destroy
    @url = Url.find(params[:id])

    # only tracked urls can be destroyed
    if current_user.nil? || current_user.id != @url.user_id
      redirect_back_or_to root_path
    end

    @url.destroy
    redirect_to user_path(current_user)
  end

  private

  def fetch(target, limit = 10)
    raise ArgumentError, "too many HTTP redirects" if limit == 0

    response = Net::HTTP.get_response(URI.parse(target))

    case response
    when Net::HTTPSuccess then
      response
    when Net::HTTPRedirection then
      location = response["location"]
      fetch(location, limit - 1)
    else
      response.value
    end
  end

  def get_location(ip)
    geo_url = "https://api-bdc.net/data/ip-geolocation?ip=#{ip}&localityLanguage=en&key=#{Rails.application.credentials.bdc_api_key}"
    p geo_url

    begin
      response =  JSON.parse(fetch(geo_url).body)
    rescue Exception => e
      puts e
      return {
        city: "NA",
        country: "NA"
      }
    end

    location = {}

    if response["location"].nil?
      location[:city] = "NA"
    else
      location[:city] = response["location"]["city"]
    end

    if response["country"].nil?
      location[:country] = "NA"
    else
      location[:country] = response["country"]["name"]
    end

    location
  end
end
