class PagesController < ApplicationController
  def home
    @url = Url.new
  end
  def analytics
    @short = params[:short].split("/")[-1]
    @url = Url.find_by(short: @short)

    if @url.nil?
      flash[:alert] = "No such links found"
      redirect_to search_path
    else
      redirect_to url_path(@url)
    end
  end

  def search
  end
end

