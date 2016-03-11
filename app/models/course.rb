class Course < ActiveRecord::Base

  has_many :prereqs

	def self.all_courses
		courses = []
		self.all.each do |course|
			courses << {id: course.id, number: course.number, title: course.title}
		end
    Utils.alpha_sort(courses, :number, true)
		return courses
	end

  def compute_prereqs_given_user user
    reqs = []
    self.prereqs.each do |prereq|
        if not user.user_courses.include? prereq
            reqs << {id: Course.find_by(title: prereq.title).id, number: prereq.number, title: prereq.title}
        end
    end
    Utils.alpha_sort(prereqs, :number, true)
    return reqs
  end

  def self.splitByColon course
    index = course.index ":"
    number = course[0..(index-1)]
    title = course[(index + 2)..(course.length - 1)]
    return title, number
  end
end
