class UsersController < ActionController::Base

  protect_from_forgery with: :exception

  before_filter CASClient::Frameworks::Rails::Filter
  before_action :require_info, :except => [:welcome, :all_courses, :all_emails, :create]
  before_action :get_info, :except => :create

  def require_info
    user_exists = User.find_by(uid: session[:cas_user]) != nil
    if not user_exists
      redirect_to "/welcome" and return
    end
  end

  def get_info
    @user = User.find_by(uid: session[:cas_user])
    @user_exists = @user != nil
    @all_courses = Course.all_courses
    @all_emails = User.all_emails
    session[:return_to] = request.referer
  end
end