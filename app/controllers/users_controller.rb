class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :show ]
  def show
    @user = User.find(params[:id])

    if @user != current_user
      flash[:alert] = "You only can view your own links"
      redirect_back_or_to root_path
    end

    @urls = @user.urls.includes(:visits)
  end
end
