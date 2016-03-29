require 'csv'
require 'set'

class Utils
  def self.alpha_sort(list, field)
    return list.sort_by!{|x|
      x[field].gsub(/\d+/){|m| "0"*(6-m.size)+m}
    }
  end

  def self.split_by_colon(course)
    index = course.index(":")
    number = course[0..(index-1)]
    title = course[(index + 2)..(course.length - 1)]
    return title, number
  end

  # def self.seedDatabase()
    
  # end

  # def self.newDataFile()
  #   begin
  #     file = File.open("newFile.csv", "w")
  #     IO.readlines('prof_data.csv').each do |line|
  #       puts line
  #       if line =~ /Rate the overall teaching/
  #         file.write(line)
  #       end
  #     end
  #   rescue IOError => e
  #     puts "lol"
  #   ensure
  #     file.close unless file.nil?
  #   end
  # end

  # def self.uniqueCourses()
  #   file = File.open("newFile3.csv", "w")
  #   all_numbers = Set.new
  #   CSV.foreach('data/classData.csv', converters: :numeric) do |line|
  #     puts line
  #     number = line[2].split(' ', 2)[0]
  #     if not all_numbers.include?(number)
  #       file.write(number + "," + "\n")
  #       all_numbers.add(number)
  #     end
  #   end
  # rescue IOError => e
  #   puts "lol"
  # ensure
  #   file.close unless file.nil?
  # end
end
