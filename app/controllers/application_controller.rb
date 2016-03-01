class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Filter Needed for CalNet Login
  before_filter CASClient::Frameworks::Rails::Filter
  before_action :require_info, :except => [:welcome, :all_courses, :create]

  def require_info
    user_exists = User.find_by(uid: session[:cas_user]) != nil
    if not user_exists
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

  def all_courses
    render :text => Course.all_courses.to_json
    # respond_to do |format|
    #   msg = {:status => "ok", :message => "Success!", :courses =>  Course.all_courses}
    #   format.json  {render :json => msg} # don't do msg.to_json
    # end
  end

  def create
    user = User.create(first_name: params[:first_name],
                        last_name: params[:last_name], email: params[:email],
                                                        uid: session[:cas_user])
    if params[:class_select] != nil
      params[:class_select].each do |course| 
        index = course.index(":")
        course_number = course[0..(index-1)]
        title = course[(index + 2)..(course.length - 1)]
        user.courses.create(title: title, course_number: course_number) 
      end
    end

    redirect_to "/user" and return
  end

  # Displays the homepage for the user
  def index
    @user = User.find_by(uid: session[:cas_user])
    @user_courses = @user.courses
  end


end
