class LoginController < ApplicationController

  skip_before_filter CASClient::Frameworks::Rails::Filter
  skip_before_action :require_info

  def index
    user_exists = User.find_by(uid: session[:cas_user]) != nil
    redirect_to "/user" and return if user_exists
    render "../views/layouts/login" and return
  end

end
