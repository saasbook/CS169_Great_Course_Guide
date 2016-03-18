# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

professors = [{name: "John Denero", distinguished: true}, {name: "Josh Hug", distinguished: true}, {name: "Satish Rao"}, {name: "Pieter Abbiel"},
	          {name: "Paul Hilfinger"}, {name: "Armando Fox"}]
courses = [{number: "CS10", title: "The Beauty and Joy of Computing"},
	       	{number: "CS61A", title: "Structure and Interpretation of Computer Programs"},
		   	{number: "CS61B", title: "Data Structures"},
			{number: "CS61C", title: "Great Ideas in Computer Architecture"},
			{number: "CS70", title: "Discrete Math and Probability"},
			{number: "CS152", title: "Computer Architecture and Engineering"},
			{number: "CS160", title: "User Interfaces"},
			{number: "CS161", title: "Computer Security"},
			{number: "CS162", title: "Operating Systems and System Programming"},
			{number: "CS164", title: "Programming Languages and Compilers"},
			{number: "CS168", title: "Internet Architecture and Protocols"},
			{number: "CS169", title: "Software Engineering"},
			{number: "CS170", title: "Efficient Algorithms and Intractable Problems"},
			{number: "CS172", title: "Computability and Complexity"},
			{number: "CS174", title: "Combinatorics and Discrete Probability"},
			{number: "CS176", title: "Algorithms for Computational Biology"},
			{number: "CS184", title: "Foundations of Computer Graphics"},
			{number: "CS186", title: "Introduction to Databases"},
			{number: "CS188", title: "Introduction to Artificial Intelligence"},
			{number: "CS189", title: "Introduction to Machine Learning"}]

i = 0
courses.each do |course|
	c = Course.create(course)
	if i != 0
		if i < 4
			c.prereqs.create(courses[i - 1])
		else
			c.prereqs.create(courses[3])
		end
	end
	i += 1
end

professors.each do |prof|
	p = Professor.create(prof)
	p.professor_courses.create(number: "CS61A", name: "Structure and Interpretation of Computer Programs", rating: Random.rand(0.0..7.0), term: "SP15")
end
