# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

professors = [{name: "John Denero"}, {name: "Josh Hug"}, {name: "Satish Rao"}, {name: "Pieter Abbiel"}, 
	          {name: "Paul Hilfinger"}, {name: "Armando Fox"}]
courses = [{number: "CS61A", title: "Structure and Interpretation of Computer Programs"}, 
			{number: "CS61B", title: "Data Structures"}, {number: "CS70", title: "Discrete Math and Probability"},
		   {number: "CS188", title: "Introduction to Artificial Intelligence"}, {number: "CS169", title: "Software Engineering"}, 
		   {number: "CS170", title: "Efficient Algorithms and Intractable Problems"}]


courses.each do |course|
	c = Course.create(course)
	c.prereqs.create(courses[0])
end

professors.each do |prof|
	p = Professor.create(prof)
	p.professor_courses.create(number: "CS61A", name: "Structure and Interpretation of Computer Programs", rating: Random.rand(0.0..7.0), term: "SP15")
end