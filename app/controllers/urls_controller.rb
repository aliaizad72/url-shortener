class UrlsController < ApplicationController
  def show
    @url = Url.find(params[:id])
  end
  def create
    target = params[:url][:target]
    begin
      response = fetch(target)
      title = Nokogiri::HTML(response.body).title
      title = "Title tag not available" if title.nil?
      @url = Url.new(target: target, title: title)

      if @url.save
        redirect_to preview_url_path(@url)
      else
        flash[:alert] = "Shortening process failed"
        redirect_to root_path
      end
    rescue Exception => e
      flash[:alert] = "#{e}"
      redirect_to root_path
    end
  end
  def redirect
    @url = Url.find_by(short: params[:short])
    redirect_to(@url.target, allow_other_host: true)
  end

  def preview
    @url = Url.find(params[:id])
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
