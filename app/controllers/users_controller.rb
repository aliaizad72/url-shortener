class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :show ]
  def show
    @user = User.find(params[:id])

    if @user != current_user
      flash[:alert] = "Unauthorized access! Log in to view your links"
      redirect_back_or_to root_path
    end

    @urls = @user.urls.reverse_order
    @pagy, @urls = pagy(@urls, limit: 8)
  end
end
