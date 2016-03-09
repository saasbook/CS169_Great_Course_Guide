class Professor < ActiveRecord::Base
    has_many :professor_courses

   	def courses
   		return self.professor_courses
   	end

    def rating
        courses = self.professor_courses
        rating_sum = courses.sum(:rating)
        num_courses = courses.length
        avg_rating = 0
        if num_courses > 0
            avg_rating = rating_sum/courses.length
        end
        return avg_rating
    end

	def self.all_profs
		profs = []
		self.all.each do |prof|
			profs << {name: prof.name, rating: prof.rating}
		end
		profs = profs.sort_by { |k| -k[:rating] }
		return profs
	end
end
