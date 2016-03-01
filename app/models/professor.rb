class Professor < ActiveRecord::Base
	

	def self.all_profs
		profs = []
	    self.select('DISTINCT name, rating').each do |prof|
	      profs << {name: prof.name, rating: prof.rating}
	    end
	    return profs
	end
end
