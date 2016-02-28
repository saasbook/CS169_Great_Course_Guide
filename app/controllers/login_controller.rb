class LoginController < ApplicationController
  skip_before_filter CASClient::Frameworks::Rails::Filter
  def index
  end
end
