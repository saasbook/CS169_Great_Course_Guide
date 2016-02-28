class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Filter Needed for CalNet Login
  before_filter CASClient::Frameworks::Rails::Filter

  def login
    user_exists = User.find_by(uid: session[:cas_user]) != nil
    if user_exists
      redirect_to "/user" and return
    else
      redirect_to "/welcome" and return
    end
  end

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
    session.clear and return
  end

  # Displays a page to allow the user to enter information
  def welcome
    user_exists = User.find_by(uid: session[:cas_user]) != nil
    if user_exists
      redirect_to "/user" and return
    end
    render "welcome", layout: false and return
  end

  def create
    user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], uid: session[:cas_user])
    if params[:class_select] != nil
        params[:class_select].each { |course| user.courses.create(title: course) }
    end

    redirect_to "/user" and return
  end

  # Displays the homepage for the user
  def index
    user_exists = User.find_by(uid: session[:cas_user]) != nil
    if not user_exists
      redirect_to "/welcome" and return
    end
  end


end
