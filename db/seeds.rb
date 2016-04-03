require 'csv'
require 'set'

Professor.destroy_all
ProfessorCourse.destroy_all
Course.destroy_all

distinguishedProfs = Hash.new
CSV.foreach('data/distinguishedProfs.csv') do |line|
  name = line[0]
  year = line[1]
  distinguishedProfs[name] = year
end

CSV.foreach('data/classNames.csv', converters: :numeric) do |line|
  number = line[0]
  title = line[1]
  Course.create(number: number, title: title)
end

CSV.foreach('data/classPrereqs.csv') do |line|
  size = line.size()
  number = line[0]
  course = Course.find_by_number(number)
  line[1..size].each do |prereq|
    course.prereqs.create(number: prereq)
  end
end

CSV.foreach('data/classData.csv', converters: :numeric) do |row|
  name = row[1] + " " + row[0] # John Denero
  number = row[2].split(' ', 2)[0] # CS61A
  term = row[2].split(' ', 2)[1] # Fall 2015

  # Calculate the rating
  total = row[4] + row[5] + row[6] + row[7] + row[8] + row[9] + row[10]
  avg = (row[4]*1 + row[5]*2 + row[6]*3 + row[7]*4 + row[8]*5 + row[9]*6 + row[10]*7).to_f
  rating = total == 0 ? 0 : (avg/total).round(2) # Rating

  professor = Professor.find_by(name: name)
  if professor.nil?
    professor = Professor.create(name: name)
    if distinguishedProfs.keys.include?(name)
      professor.distinguished = true
      professor.distinguishedYear = distinguishedProfs[name]
      professor.save
    end
  end

  course = Course.find_by(number: number)
  if course
    courseName = Course.find_by(number: number).title
    professor.courses.create(number: number, rating: rating, term: term, name: courseName)
  else
    invalid << number
  end
end
