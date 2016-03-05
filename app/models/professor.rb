class Professor < ActiveRecord::Base
    has_many :professor_courses

   	def courses
   		return self.professor_courses
   	end

	def self.all_profs
		profs = []
		self.all.each do |prof|
			courses = prof.professor_courses
			rating_sum = courses.sum(:rating)
			num_courses = courses.length
			avg_rating = 0
			if num_courses > 0
				avg_rating = rating_sum/courses.length
			end
			profs << {name: prof.name, rating: avg_rating.round(1)}
		end
		profs = profs.sort_by { |k| -k[:rating] }
		return profs
	end
end
