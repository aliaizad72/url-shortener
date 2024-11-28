class VisitsController < ApplicationController
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
end
