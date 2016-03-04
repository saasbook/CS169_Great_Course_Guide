class Professor < ActiveRecord::Base
    has_many :professor_courses

   	def courses
   		return self.professor_courses
   	end

	def self.all_profs
		profs = []
		self.all.each do |prof|
			courses = prof.professor_courses
			rating_sum = 0
			course_count = 0
			courses.each do |course|
				rating_sum += course.rating
				course_count += 1
			end
			avg_rating = rating_sum/course_count
			profs << {name: prof.name, rating: avg_rating.round(1)}
		end
		profs = profs.sort_by { |k| -k[:rating] }
		return profs
	end
end
