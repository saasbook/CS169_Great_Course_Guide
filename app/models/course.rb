class Course < ActiveRecord::Base
    has_many :prereqs

	def self.all_courses
		courses = []
		self.all.order(number: :asc).each do |course|
			courses << {id: course.id, number: course.number, title: course.title}
		end
		return courses
	end

    def compute_prereqs_given_user user
        reqs = []
        self.prereqs.each do |prereq|
            if not user.user_courses.include? prereq
                reqs << {id: Course.where(title: prereq.title).first.id, number: prereq.number, title: prereq.title}
            end
        end
        return reqs
    end

    def self.splitByColon course
        index = course.index ":"
        number = course[0..(index-1)]
        title = course[(index + 2)..(course.length - 1)]
        return title, number
    end

end
