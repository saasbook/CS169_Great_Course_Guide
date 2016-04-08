class User < ActiveRecord::Base

	validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: true
	has_many :user_courses

	def self.all_emails
		emails = []
		self.all.each { |user| emails << user.email }
		return emails
	end

	def courses
		courses = []
		self.user_courses.each do |course|
		courses << {id: Course.find_by(number: course.number).id,
						    number: course.number, title: course.title, taken: course.taken}
		end
    	Utils.alpha_sort(courses, :number)
		return courses
	end

	def has_taken(prereq)
    	user_course = self.user_courses.find_by(number: prereq.number)
    	return (user_course != nil and user_course.taken)
	end
end
