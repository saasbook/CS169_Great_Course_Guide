class Professor < ActiveRecord::Base
	

	def self.all_profs
		profs = []
	    self.select('name, rating').order(rating: :desc).each do |prof|
	      profs.push({name: prof.name, rating: prof.rating})
	    end
	    return profs
	end
end
