require 'csv'

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

  def self.parseData()
    all = []
    CSV.foreach('prof_data_min.csv', converters: :numeric) do |row|
      name = row[1] + " " + row[0]
      course = row[2]
      question = row[3]
      total = row[4] + row[5] + row[6] + row[7] + row[8] + row[9] + row[10]
      avg = (row[4]*1 + row[5]*2 + row[6]*3 + row[7]*4 + row[8]*5 + row[9]*6 + row[10]*7).to_f
      avg = (avg/total).round(2)
      entry = all.find { |hash| hash[:name] == name and hash[:course] == course}
      if entry
        entry[:questions][question] = avg
      else
        hash = {:name => name, :course => course, :questions => {}}
        hash[:questions][question] = avg
        all << hash
      end
    end
    puts all
  end
end
