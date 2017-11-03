class CoursesController < ApplicationController

  def index
    if not session[:filter_settings]
      @filter_settings = {ee: true, cs: true, lower: true, upper: true, grad: true}
    else
      @filter_settings = session[:filter_settings]
    end
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

  def schedule
    @recommended_EECS_courses = @user.recommended_EECS_courses
    
    # for filtering out "Best Alternative Courses"
    # who's ratings are lower than "Courses You're Interested In"
    # the overall rating for the professors teaching a course
    # is stored in the [2] index of a course;
    # [0] and [1] contain course and professor metadata respectively
    if not @recommended_EECS_courses[:possible_fall].blank?
      min_fall_recommended_rating = @recommended_EECS_courses[:possible_fall].min_by {|x| x[2]}[2]
      @recommended_EECS_courses[:backup_fall] = @recommended_EECS_courses[:backup_fall].select{|a| a[2] > min_fall_recommended_rating}
    end
    if not @recommended_EECS_courses[:possible_spring].blank?
      min_spring_recommended_rating = @recommended_EECS_courses[:possible_spring].min_by {|x| x[2]}[2]
      @recommended_EECS_courses[:backup_spring] = @recommended_EECS_courses[:backup_spring].select{|a| a[2] > min_spring_recommended_rating}
    end
    
    @fall_length = @recommended_EECS_courses[:possible_fall].length + @recommended_EECS_courses[:backup_fall].length
    @spring_length = @recommended_EECS_courses[:possible_spring].length + @recommended_EECS_courses[:backup_spring].length
    @recommended_breadth_courses = @user.recommended_breadth_courses
    @breadth_length = @recommended_breadth_courses.length
  end
end
