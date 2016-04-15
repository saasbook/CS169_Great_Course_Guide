class Professor < ActiveRecord::Base
  has_many :professor_courses
  validates_uniqueness_of :name

  def courses
    return self.professor_courses
  end

  def unique_courses
    return ProfessorCourse.where(professor_id: self.id).uniq.select(:name, :number, :rating)
  end

  def rating
    rating_sum = self.courses.sum(:rating)
    num_courses = self.courses.length
    return num_courses == 0 ? "*" : (rating_sum / num_courses).round(2)
  end

  def rating_for(course_number)
    total = 0
    self.professor_courses.where(number: course_number).each do |professor_course|
      total += professor_course.rating
    end
    return (total / self.professor_courses.where(number: course_number).length).round(2)
  end

	def self.all_profs(type)
		profs = []
		self.where(category: type).each do |prof|
      if not prof.name == "TBA"
			 profs << {id: prof.id, name: prof.name, rating: prof.rating}
      end
		end
    profs.sort_by do |prof|
      if prof[:rating] == "*"
        0
      else
        -prof[:rating]
      end
    end
	end


  def self.dist_profs(type)
    dist_profs = []
    self.where(category: type).each do |prof|
      if prof.distinguished
        dist_profs << {id: prof.id, name: prof.name, rating: prof.rating, year: prof.distinguishedYear}
      end
    end
    dist_profs.sort_by do |prof|
      if prof[:rating] == "*"
        0
      else
        -prof[:rating]
      end
    end
  end
end
