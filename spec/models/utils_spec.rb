require "spec_helper"
require "rails_helper"

describe Utils do
  describe '#alpha_sort' do
    it 'sorts mixed strings alphanumerically' do
      list = [{str: "A001B005"}, {str: "A02B7"}, {str: "A1B3"}, {str: "A9A16"}, {str: "A2B4"}]
      sorted_list = Utils.alpha_sort(list, :str)

      expect(sorted_list.length).to eq(list.length)
      expect(sorted_list[0][:str]).to eq("A1B3")
      expect(sorted_list[1][:str]).to eq("A001B005")
      expect(sorted_list[2][:str]).to eq("A2B4")
      expect(sorted_list[3][:str]).to eq("A02B7")
      expect(sorted_list[4][:str]).to eq("A9A16")
    end
  end
  describe '#split_by_colon' do
    it 'splits course descriptions by colon and space' do
      course_description = "CS61A: SICP"
      course_description2 = "CS61J: Introduction To: SICP"
      title, number = Utils.split_by_colon(course_description)
      title2, number2 = Utils.split_by_colon(course_description2)

      expect(title).to eq("SICP")
      expect(number).to eq("CS61A")
      expect(title2).to eq("Introduction To: SICP")
      expect(number2).to eq("CS61J")
    end
  end
end
