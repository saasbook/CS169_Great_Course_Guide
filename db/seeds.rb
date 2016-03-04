# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

professors = [{name: "John Denero"}, {name: "Josh Hug"}, {name: "Satish Rao"}, {name: "Pieter Abbiel"}, 
	          {name: "Paul Hilfinger"}, {name: "Armando Fox"}]
courses = [{number: "CS61A", title: "Title1"}, {number: "CS61B", title: "Title2"}, {number: "CS70", title: "Title3"},
		   {number: "CS188", title: "Title4"}, {number: "CS169", title: "Title5"}, {number: "CS170", title: "Title6"}]


courses.each do |course|
	c = Course.create(course)
	c.prereqs.create(courses[0])
end

professors.each do |prof|
	p = Professor.create(prof)
	p.courses.create(number: "CS61A", name: "Intro to CS", rating: Random.rand(0..7), term: "SP15")
end