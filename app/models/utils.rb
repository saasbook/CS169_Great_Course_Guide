class Utils
  def self.alpha_sort(list, field, ascending)
    l = list.sort{|a, b|
      a[field],b[field] = [a[field],b[field]].map{|s| s.gsub(/\d+/){|m| "0"*(3 - m.size) + m }}
      a[field]<=>b[field]
    }
    l.each do |item|
      item[field] = item[field].gsub(/0(?=\d+)/) {}
    end
    if !ascending
      l.reverse!
    end
    return l
  end
end
