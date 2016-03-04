class Course < ActiveRecord::Base
    has_many :prereqs
    
	def self.all_courses
		courses = []
		self.select('DISTINCT number, title').each do |course|
			courses << {id: course.id, number: course.number, title: course.title}
		end
		return courses
	end

    def compute_prereqs_given_user user
        prereqs = []
        self.prereqs.each do |prereq|
            if not user.user_courses.include? prereq
                prereqs << prereq
            end
        end
        return prereqs
    end

    def self.splitByColon course
        index = course.index ":"
        number = course[0..(index-1)]
        title = course[(index + 2)..(course.length - 1)]
        return title, number
    end

end
