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
end
