require 'csv'
require 'set'

class Utils
  def self.alpha_sort(list, field)
    return list.sort_by!{ |x|
      x[field].gsub(/\d+/) { |m| "0"*(6 - m.size) + m }
    }
  end

  def self.split_by_colon(course)
    index = course.index(":")
    number = course[0..(index-1)]
    title = course[(index + 2)..(course.length - 1)]
    return title, number
  end

  def self.draft_schedule
    fall_2016 = Hash.new
    DraftCourse.where(term: "FA16").each do |draft_course|
      fall_2016[draft_course.course.number] = draft_course.professor
    end
    spring_2017 = Hash.new
    DraftCourse.where(term: "SP17").each do |draft_course|
      spring_2017[draft_course.course.number] = draft_course.professor
    end
    return {fall: fall_2016, spring: spring_2017}
  end

  def self.breadth_schedule
    fall_2016_breadth = Set.new
    CSV.foreach('data/fall2016breadths.csv') do |line|
      fall_2016_breadth.add(line)
    end
    return fall_2016_breadth
  end

  def self.addDTA()
    begin
      file = File.open("awards.csv", "w")
      IO.readlines("data/distinguishedProfs.csv").each do |line|
        file.write(line.strip + " Distinguished Teaching Award\n")
      end
    rescue IOError => e
      puts "Error"
    ensure
      file.close unless file.nil?
    end
  end
end
