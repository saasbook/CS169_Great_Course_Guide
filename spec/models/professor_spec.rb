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
			@professor1 = Professor.create(name: "John Denero", distinguished: true, distinguishedYear: "2016", category: "EECS")
			@professor2 = Professor.create(name: "Josh Hug", category: "EECS")
			@professor3 = Professor.create(name: "Bleh", category: "EECS", distinguished: true, distinguishedYear: "2017")

			@course1 = ProfessorCourse.create(number: "CS61A", name: "Test Title 1", rating: 5.0, term: "Fall 2016")
			@course2 = ProfessorCourse.create(number: "CS61B", name: "Test Title 2", rating: 3.0, term: "Spring 2016")
			@course3 = ProfessorCourse.create(number: "CS61C", name: "Test Title 3", rating: 2.0, term: "Fall 2016")
			@course4 = ProfessorCourse.create(number: "CS61D", name: "Test Title 4", rating: 4.0, term: "Spring 2016")
			@course5 = ProfessorCourse.create(number: "CS61E", name: "Nah", rating: "*", term: "Spring 2017")

			@professor1.professor_courses << @course1
			@professor1.professor_courses << @course2

			@professor2.professor_courses << @course3
			@professor2.professor_courses << @course4

			@professor3.professor_courses << @course5

			@prof1_avg = {id: 1, name: "John Denero", rating: 4.0}
			@prof2_avg = {id: 2, name: "Josh Hug", rating: 3.0}
			@prof3_avg = {id: 3, name: "Bleh", rating: 0.0}
		end

		it 'should return a list of all professors' do
			expect(Professor.all_profs("EECS")).to include(@prof1_avg)
			expect(Professor.all_profs("EECS")).to include(@prof2_avg)
			expect(Professor.all_profs("EECS")).to include(@prof3_avg)
		end

		it 'should sort professors by rating' do
			expect(Professor.all_profs("EECS").first).to eq(@prof1_avg)
			expect(Professor.all_profs("EECS").second).to eq(@prof2_avg)
			expect(Professor.all_profs("EECS").third).to eq(@prof3_avg)
		end

		it 'should filter by distinguished teachers' do
			expect(Professor.dist_profs("EECS").length).to equal(2)
			expect(Professor.dist_profs("EECS").first[:name]).to eql("John Denero")
			expect(Professor.dist_profs("EECS").first[:year]).to eql("2016")
			expect(Professor.dist_profs("EECS").second[:name]).to eql("Bleh")
		end

		it 'should have the average rating of the professor' do
			all_profs = Professor.all_profs("EECS")
			all_profs.each do |prof_avg|
				name = prof_avg[:name]
				if name == "John Denero"
					expect(prof_avg[:rating]).to eq(@prof1_avg[:rating])
				end
				if name == "Josh Hug"
					expect(prof_avg[:rating]).to eq(@prof2_avg[:rating])
				end
				if name == "Bleh"
					expect(prof_avg[:rating]).to eq(@prof3_avg[:rating])
				end
			end
		end

		it 'should return all proper info for the graph' do
			chart_info = @professor1.chart_info
			@professor1.courses.each do |p_course|
				expect(chart_info[0]).to include(p_course.number + " " + p_course.term)
				expect(chart_info[1]).to include(p_course.rating)
			end
		end
	end
end