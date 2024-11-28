class VisitsController < ApplicationController
  require "csv"
  def index
    @url = Url.find(params[:url_id])

    # if url was created with a user, the report only available to the user
    if @url.user_id
      if current_user.nil? || current_user.id != @url.user_id
        flash[:alert] = "Unauthorized access! The analytics page is only available to the user that created the short link."
        redirect_to root_path
      end
    end

    @visits_count = @url.visits.count
    @visits = @url.visits.limit(200)
    @pagy, @visits = pagy(@visits, limit: 12)
  end

  def download
    @url = Url.find(params[:url_id])

    # if url was created with a user, the report only available to the user
    if @url.user_id
      if current_user.nil? || current_user.id != @url.user_id
        flash[:alert] = "Unauthorized access! Downloading analytics report is only available to the user that created the short link."
        redirect_to root_path
      end
    end

    @visits = @url.visits

    begin
      compressed_filestream = Zip::OutputStream.write_buffer(::StringIO.new("")) do |zip|
        zip.put_next_entry "#{@url.short}-#{DateTime.now.strftime("%d%m%Y%H%M")}.csv"
        zip.print to_csv(@visits)
      end
      compressed_filestream.rewind
      send_data compressed_filestream.read, filename: "#{@url.short}-#{DateTime.now.strftime("%d%m%Y%H%M")}.zip"
    rescue Exception => e
      flash[:alert] = "#{e}"
      redirect_to url_visits_path(@url)
    end
  end

  def analytics
    @short = params[:url].split("/")[-1]
    @url = Url.find_by(short: @short)

    if @url.nil?
      flash[:alert] = "No such links found"
      redirect_to visits_search_path
    else
      redirect_to url_visits_path(@url)
    end
  end

  def search
  end

  private

  def to_csv(visits)
    column_names = visits[0].attributes.keys
    CSV.generate do |csv|
      csv << column_names
      visits.each do |visit|
        csv << visit.attributes.values_at(*column_names)
      end
    end
  end
end
