class CoursesController < ActionController::Base

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

  def index
  end

  def show
    @course = Course.find(params[:id])
    all_prereqs = @course.compute_prereqs_given_user(@user)
    @remaining_prereqs = all_prereqs[0]
    @finished_prereqs = all_prereqs[1]

    @professorCourses = ProfessorCourse.where(number: @course.number)
    @professors = Set.new
    @professorCourses.each do |professorCourse|
      @professors << professorCourse.professor
    end
    @professors = @professors.sort_by { |professor| -professor.rating}
  end

  def all
    render :text => @all_courses.to_json
  end
end