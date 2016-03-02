class Course < ActiveRecord::Base
  belongs_to :user

  def self.all_courses
    courses = []
    self.select('DISTINCT course_number, title')
    .order(course_number: :desc).each do |course|
      courses << {course_number: course.course_number, title: course.title}
    end
    return courses
  end
end
