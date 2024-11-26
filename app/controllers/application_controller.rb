class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: { ie: false }

  def after_sign_in_path_for(user)
    user_path(current_user)
  end
end
