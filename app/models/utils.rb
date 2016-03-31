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

  # def self.fixProfs
  #   begin
  #     file = File.open("newFile4.csv", "w")
  #     year = 0
  #     IO.readlines('data/distinguishedProfs.csv').each do |line|
  #       arr = line.split(' - ')
  #       if arr.length == 1
  #         year = arr[0]
  #       else
  #         file.write(arr[0] + "," + year)
  #       end
  #     end
  #   rescue IOError => e
  #     puts "lol"
  #   ensure
  #     file.close unless file.nil?
  #   end
  # end

  # def self.fixData
  #   begin
  #     file = File.open("newFile4.csv", "w")
  #     IO.readlines('data/classData.csv').each do |line|
  #       puts line
  #       year = line.split(',')[2].split(" ")[2].to_i
  #       if year >= 2005
  #         file.write(line)
  #       end
  #     end
  #   rescue IOError => e
  #     puts "lol"
  #   ensure
  #     file.close unless file.nil?
  #   end
  # end

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

  # def self.fixTitles
  #   begin
  #     file = File.open("newFile3.csv", "w")
  #     all_numbers = Set.new
  #     CSV.foreach('data/classData.csv', converters: :numeric) do |line|
  #       number = line[2].split(' ', 2)[0]
  #       all_numbers.add(number)
  #     end

  #     IO.readlines('data/classNames.csv').each do |line|
  #       num = line.split(",")[0]
  #       if all_numbers.include?(num)
  #         file.write(line)
  #       end
  #     end
  #   rescue IOError => e
  #     puts "lol"
  #   ensure
  #     file.close unless file.nil?
  #   end
  # end

  # def self.fixData
  #   begin
  #     file = File.open("newData.csv", "w")
  #     all_numbers = Set.new
  #     CSV.foreach('newFile3.csv', converters: :numeric) do |line|
  #       number = line[0]
  #       all_numbers.add(number)
  #     end

  #     IO.readlines('data/classData.csv').each do |line|
  #       num = line.split(",")[2].split(" ")[0]
  #       if all_numbers.include?(num)
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
