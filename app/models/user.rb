class User < ActiveRecord::Base

	validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :uid, presence: true, uniqueness: true
	has_many :user_courses

	def self.all_emails
		emails = []
		self.all.each do |user|
			emails << user.email
		end
		return emails
	end

	def courses
		courses = []
		self.user_courses.each do |course|
			courses << {id: Course.find_by(number: course.number).id,
						number: course.number, title: course.title}
		end
    	Utils.alpha_sort(courses, :number)
		return courses
	end

	def has_taken prereq
		self.user_courses.each do |course|
			if course.number == prereq.number
				return true
			end
		end
		return false
	end
end
