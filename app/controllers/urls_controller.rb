class UrlsController < ApplicationController
  def create
    target = params[:url][:target]
    begin
      response = fetch(target)
      title = Nokogiri::HTML(response.body).title
    rescue Exception => e
      p e
      flash[:alert] = "#{e}"
      redirect_to root_path
    end
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
end
