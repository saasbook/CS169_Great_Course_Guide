class LoginController < ApplicationController
  skip_before_filter CASClient::Frameworks::Rails::Filter
  skip_before_action :require_info
  def index
    user_exists = User.find_by(uid: session[:cas_user]) != nil
    if user_exists
      redirect_to "/user" and return
    end
    render "../views/layouts/login", layout: false and return
  end
end
