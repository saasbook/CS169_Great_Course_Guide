class Course < ActiveRecord::Base

  has_many :prereqs

	def self.all_courses
		courses = []
		self.all.each do |course|
			courses << {id: course.id, number: course.number, title: course.title}
		end
    Utils.alpha_sort(courses, :number)
		return courses
	end

  def compute_prereqs_given_user user
    reqs = []
    self.prereqs.each do |prereq|
        if not user.has_taken(prereq)
            reqs << {id: Course.find_by(number: prereq.number).id, number: prereq.number, title: prereq.title, course_id: prereq.course_id}
        end
    end
    Utils.alpha_sort(reqs, :number)
    return reqs
  end
end
