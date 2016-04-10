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

  def wants_to_take(course_number)
    user_course = self.user_courses.find_by(number: course_number)
    return (user_course != nil and not user_course.taken)
  end

  def can_take(course_number)
    prereqs = Course.find_by(number: course_number).prereqs
    prereqs.each do |prereq|
      if not has_taken(prereq)
        return false
      end
    end
    return true
  end

  def added_courses
    return self.courses.select { |course| not course[:taken] }
  end

  def taken_courses
    return self.courses.select { |course| course[:taken] }
  end

  def recommended_EECS_courses
    draft_schedule = Utils.draft_schedule
    fall_courses = draft_schedule[0]
    spring_courses = draft_schedule[1]

    possible_fall_courses = []
    backup_fall_courses = []
    fall_courses.each_key do |course_number|
      if self.wants_to_take(course_number) and self.can_take(course_number)
        possible_fall_courses << course_number
      elsif self.can_take(course_number)
        backup_fall_courses << course_number
      end
    end

    possible_spring_courses = []
    backup_spring_courses = []
    spring_courses.each_key do |course_number|
      if self.wants_to_take(course_number) and self.can_take(course_number)
        possible_spring_courses << course_number
      elsif self.can_take(course_number)
        backup_spring_courses << course_number
      end
    end
    return [possible_fall_courses, backup_fall_courses, possible_spring_courses, backup_spring_courses]
  end


end
