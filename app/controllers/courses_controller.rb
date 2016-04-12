class CoursesController < ApplicationController

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

  def schedule
    @recommended_EECS_courses = @user.recommended_EECS_courses
    puts @recommended_EECS_courses
  end
end
