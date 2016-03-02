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

  def self.splitByColon(course)
  	index = course.index(":")
    course_number = course[0..(index-1)]
    title = course[(index + 2)..(course.length - 1)]
    return title, course_number
  end

end
