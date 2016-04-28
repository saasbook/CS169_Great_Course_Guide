class Course < ActiveRecord::Base

  has_many :prereqs
  has_many :draft_courses
  validates_uniqueness_of :number

	def self.all_courses
		courses = []
		self.all.each do |course|
			courses << {id: course.id, number: course.number, title: course.title, units: course.units}
		end
    Utils.alpha_sort(courses, :number)
		return courses
	end

  def compute_prereqs_given_user(user)
    remaining_reqs = []
    finished_reqs = []
    self.prereqs.each do |prereq|
      req = {id: Course.find_by(number: prereq.number).id,
                number: prereq.number, title: Course.find_by(number:  prereq.number).title, course_id: prereq.course_id}
      if user.has_taken(prereq) then finished_reqs << req else remaining_reqs << req end
    end
    Utils.alpha_sort(remaining_reqs, :number)
    Utils.alpha_sort(finished_reqs, :number)
    return remaining_reqs, finished_reqs
  end

  def self.filter
    map = {}
    self.all.each do |course|
      department = course.number[0..1]
      course.number =~ /(\d+)/
      num = $1.to_i
      div = num < 100 ? "_LOWER_DIV" : (num < 200 ? "_UPPER_DIV" : "_GRAD")
      map[course.number] = department + div
    end
    return map
  end
end
