class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Filter Needed for CalNet Login
  before_filter CASClient::Frameworks::Rails::Filter

  def index
    puts "CHECK"
  end

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
    return
  end
end
