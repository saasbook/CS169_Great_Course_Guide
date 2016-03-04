class Course < ActiveRecord::Base
    has_many :prereqs
    
	def self.all_courses
		courses = []
		self.select('DISTINCT number, title').each do |course|
			courses << {course_number: course.number, title: course.title}
		end
		return courses
	end
end
