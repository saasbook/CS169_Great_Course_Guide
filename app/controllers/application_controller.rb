class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Filter Needed for CalNet Login
  before_filter CASClient::Frameworks::Rails::Filter
  before_action :require_info, :except => [:welcome, :all_courses, :all_emails, :create]
  before_action :get_info

  def require_info
    user_exists = User.find_by(uid: session[:cas_user]) != nil
    if not user_exists
      redirect_to "/welcome" and return
    end
  end

  def get_info
    @user = User.find_by(uid: session[:cas_user])
    @user_exists = @user != nil
    if @user_exists
      @user_courses = @user.courses
    end
    @all_courses = Course.all_courses
    @all_profs = Professor.all_profs
    @all_emails = User.all_emails
  end

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
    session.clear and return
  end

  # Displays a page to allow the user to enter information
  def welcome
    redirect_to "/user" and return if @user_exists

    render "welcome", layout: false and return
  end

  def classes
  end

  def professors
  end

  def all_courses
    render :text => @all_courses.to_json
  end

  def all_emails
    render :text => @all_emails.to_json
  end

  def create
    # TODO: Need to validate params
    @user = User.create(first_name: params[:first_name],
                        last_name: params[:last_name], email: params[:email],
                                                        uid: session[:cas_user])
    puts @user
    if params[:class_select] != nil
      params[:class_select].each do |course|
        attrs = Course.splitByColon(course)
        puts @user.valid?
        @user.courses.create(title: attrs[0], course_number: attrs[1])
      end
    end

    redirect_to "/user" and return
  end

  def index
  end

  def edit
    @user_classNames = []
    @user_courses.each do |course|
      @user_classNames << course.course_number
    end
  end

  def update
    @user.courses.destroy_all

    if params[:classes] != nil
      params[:classes].each_key do |course|
        attrs = Course.splitByColon(course)
        @user.courses.create(title: attrs[0], course_number: attrs[1])
      end
    end

    redirect_to "/user" and return
  end

end
