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
    course = Course.find_by(number: course_number)
    if has_taken(course)
      return false
    end
    course.prereqs.each do |prereq|
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
    fall_courses = draft_schedule[:fall]
    spring_courses = draft_schedule[:spring]

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

    get_course_data(possible_fall_courses, fall_courses)
    get_course_data(backup_fall_courses, fall_courses)
    get_course_data(possible_spring_courses, spring_courses)
    get_course_data(backup_spring_courses, spring_courses)

    return { possible_fall: possible_fall_courses,
             backup_fall: backup_fall_courses,
             possible_spring: possible_spring_courses,
             backup_spring: backup_spring_courses }
  end

  def recommeded_breadth_courses
    breadth_draft_schedule = Utils.breadth_draft_schedule
    fall_breadth_courses = breadth_draft_schedule[:fall]
    spring_breadth_courses = breadth_draft_schedule[:spring]

    distinguished_fall_breadth_courses = []
    fall_breadth_courses.each_key do |course_number|
      professors = fall_breadth_courses[course_number] # HOW TO DO DIS
      professors.each do |professor|
        if professor.distinguished
          distinguished_fall_breadth_courses << course_number
          break
        end
      end
    end

    distinguished_spring_breadth_courses = []
    spring_breadth_courses.each_key do |course_number|
      professors = spring_breadth_courses[course_number]
      professors.each do |professor|
        if professor.distinguished
          distinguished_fall_breadth_courses << course_number
          break
        end
      end
    end

    get_course_data(distinguished_fall_breadth_courses, fall_breadth_courses)
    get_course_data(distinguished_spring_breadth_courses, spring_breadth_courses)

    return {breadth_fall: distinguished_fall_breadth_courses
            breadth_spring: distinguished_spring_breadth_courses }
  end

  private
  def get_average_rating_of_professors(professors)
    total = 0
    num_professors = 0
    professors.each do |name|
      puts name
      if name == "TBA"
        next
      end
      professor = Professor.find_by(name: name)
      if professor
        if professor.rating
          total += professor.rating
          num_professors += 1
        end
      end
    end
    return (total / num_professors).round(2) if num_professors > 0 else "*"
  end

  private
  def get_course_data(course_list, term_list)
    course_list.map! { |course_number| [Course.find_by(number: course_number),
              term_list[course_number].split(";"),
              get_average_rating_of_professors(term_list[course_number].split(";"))] }
    course_list.each do |data|
      new_professors = []
      data[1].each do |professor_name|
        new_professors << Professor.find_by(name: professor_name)
      end
      data[1] = new_professors
    end

    course_list.sort_by! do |data|
      if data[2] == "*"
        0
      else
        -data[2]
      end
    end
    #course_list.slice!(7,course_list.length)
  end
end
