class Professor < ActiveRecord::Base
    has_many :professor_courses


	def self.all_profs
		profs = []
		self.select('DISTINCT name').each do |prof|
			courses = prof.professor_courses
			avg_rating = 0
			courses.each do |course|
				avg_rating += course.rating
			end
			profs << {name: prof.name, rating: avg_rating}
		end
		return profs
	end
end
