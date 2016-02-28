class LoginController < ApplicationController
  skip_before_filter CASClient::Frameworks::Rails::Filter
  def index
    user_exists = User.find_by(uid: session[:cas_user]) != nil
    if user_exists
      redirect_to "/user" and return
    end
  end
end
