class Professor < ActiveRecord::Base
  has_many :professor_courses
  validates_uniqueness_of :name

  def courses
    self.professor_courses
  end

  def rating
    rating_sum = self.courses.sum(:rating)
    num_courses = self.courses.length
    return num_courses == 0 ? 0 : (rating_sum / num_courses).round(2)
  end

	def self.all_profs
		profs = []
		self.all.each do |prof|
			profs << {id: prof.id, name: prof.name, rating: prof.rating}
		end
		return profs.sort_by { |professor| -professor[:rating] }
	end

  def self.dist_profs
    dist_profs = []
    self.all.each do |prof|
      if prof.distinguished
        dist_profs << {id: prof.id, name: prof.name, rating: prof.rating, year: prof.distinguishedYear}
      end
    end
    return dist_profs.sort_by { |professor| -professor[:rating] }
  end
end
