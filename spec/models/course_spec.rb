require "spec_helper"
require "rails_helper"

describe Course do
  describe '.all_courses' do
    before(:each) do
      Course.destroy_all()
    end
    context 'there are no courses' do
      it 'should return nothing' do
        all_courses = Course.all_courses()
        expect(all_courses).to be_empty
      end
    end
    context 'there are courses' do
      it 'should return every course in order' do
        Course.create(number: "CS61B", title: "Data Strucutres")
        Course.create(number: "CS61A", title: "SICP")
        Course.create(number: "CS169", title: "Software Engineering")
        Course.create(number: "CS61C", title: "Computer Architecture")

        all_courses = Course.all_courses()

        expect(all_courses.length).to be(4)
        expect(all_courses[0][:number]).to eq("CS61A")
        expect(all_courses[1][:number]).to eq("CS61B")
        expect(all_courses[2][:number]).to eq("CS61C")
        expect(all_courses[3][:number]).to eq("CS169")
      end
    end
  end

  describe '#compute_prereqs_given_user' do
    before(:each) do
      Course.destroy_all()
      User.destroy_all()
      Course.create(number: "CS61A", title: "SICP")
      Course.create(number: "CS61B", title: "Data Strucutres")
      Course.create(number: "CS61C", title: "Computer Architecture")
      Course.find(3).prereqs.create(number: "CS61B", title: "Data Strucutres")
      Course.find(3).prereqs.create(number: "CS61A", title: "SICP")
      User.create(first_name: "John", last_name: "Doe", uid: "00000001", email: "john.doe@university.edu")
    end
    context 'user has taken no prereqs' do
      it 'should return all prereqs in order' do
        user = User.find(1)
        prereqs = Course.find(3).compute_prereqs_given_user(user)

        expect(prereqs.length).to be(2)
        expect(prereqs[0][:number]).to eq("CS61A")
        expect(prereqs[1][:number]).to eq("CS61B")
      end
    end
    context 'user has taken some prereqs' do
      it 'should return remaining prereqs' do
        user = User.find(1)
        user.user_courses.create(number: "CS61A", title: "SICP")
        prereqs = Course.find(3).compute_prereqs_given_user(user)

        expect(prereqs.length).to be(1)
        expect(prereqs[0][:number]).to eq("CS61B")
      end
    end
    context 'user has taken all prereqs' do
      it 'should return no prereqs' do
        user = User.find(1)
        user.user_courses.create(number: "CS61A", title: "SICP")
        user.user_courses.create(number: "CS61B", title: "SICP")
        prereqs = Course.find(3).compute_prereqs_given_user(user)

        expect(prereqs).to be_empty
      end
    end
  end
end
