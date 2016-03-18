require "spec_helper"
require "rails_helper"

describe Professor do
	describe "getting a professor's courses" do
		it 'should return all of the courses the professor is teaching' do
			professor = Professor.new(name: "John Denero")

			course1 = ProfessorCourse.new(number: "CS61A", name: "Test Title 1", rating: 9.9, term: "Fall 2016")
			course2 = ProfessorCourse.new(number: "CS61B", name: "Test Title 2", rating: 6.9, term: "Spring 2016")

			professor.professor_courses << course1
			professor.professor_courses << course2

			all_courses = professor.courses

			expect(all_courses).not_to be_empty
			expect(all_courses).to include(course1)
			expect(all_courses).to include(course2)
		end
	end

	describe "returns a list of all professors" do
		before :each do
			Professor.destroy_all
			@professor1 = Professor.create(name: "John Denero", distinguished: true)
			@professor2 = Professor.create(name: "Josh Hug")

			@course1 = ProfessorCourse.create(number: "CS61A", name: "Test Title 1", rating: 5.0, term: "Fall 2016")
			@course2 = ProfessorCourse.create(number: "CS61B", name: "Test Title 2", rating: 3.0, term: "Spring 2016")
			@course3 = ProfessorCourse.create(number: "CS61C", name: "Test Title 3", rating: 2.0, term: "Fall 2016")
			@course4 = ProfessorCourse.create(number: "CS61D", name: "Test Title 4", rating: 4.0, term: "Spring 2016")

			@professor1.professor_courses << @course1
			@professor1.professor_courses << @course2

			@professor2.professor_courses << @course3
			@professor2.professor_courses << @course4

			@prof1_avg = {name: "John Denero", rating: 4.0}
			@prof2_avg = {name: "Josh Hug", rating: 3.0}
		end

		it 'should return a list of all professors' do
			expect(Professor.all_profs).to include(@prof1_avg)
			expect(Professor.all_profs).to include(@prof2_avg)
		end

		it 'should sort professors by rating' do
			expect(Professor.all_profs.first).to eq(@prof1_avg)
			expect(Professor.all_profs.second).to eq(@prof2_avg)
		end

		it 'should filter by distinguished teachers' do
			expect(Professor.dist_profs.length).to equal(1)
			expect(Professor.dist_profs.first[:name]).to eql("John Denero")
		end

		it 'should have the average rating of the professor' do
			all_profs = Professor.all_profs
			all_profs.each do |prof_avg|
				name = prof_avg[:name]
				if name == "John Denero"
					expect(prof_avg[:rating]).to eq(@prof1_avg[:rating])
				end
				if name == "Josh Hug"
					expect(prof_avg[:rating]).to eq(@prof2_avg[:rating])
				end
			end
		end
	end
end