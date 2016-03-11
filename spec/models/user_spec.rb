require "spec_helper"
require "rails_helper"

describe User do
  describe '#all_emails' do
    before(:each) do
      User.destroy_all()
    end
    context 'there are no users' do
      it 'should return nothing' do
        emails = User.all_emails()

        expect(emails).to be_empty
      end
    end
    context 'there are users' do
      it 'should return all emails' do
        User.create(first_name: "John", last_name: "Doe", uid: "00000001", email: "john.doe@university.edu")
        User.create(first_name: "Jane", last_name: "Doe", uid: "00000002", email: "jane.doe@university.edu")
        emails = User.all_emails()

        expect(emails.length).to be(2)
        expect(emails).to include("john.doe@university.edu")
        expect(emails).to include("jane.doe@university.edu")
      end
    end
  end
  describe '.courses' do
    before(:each) do
      User.destroy_all()
      User.create(first_name: "John", last_name: "Doe", uid: "00000001", email: "john.doe@university.edu")
    end
    context 'user has taken no courses' do
      it 'should return nothing' do
        user = User.find(1)
        courses = user.courses()

        expect(courses).to be_empty
      end
    end

    context 'user has taken courses' do
      it 'should return all courses taken by user in sorted order' do
        user = User.find(1)
        Course.create(number: "CS61A", title: "SICP")
        Course.create(number: "CS61B", title: "Data Structures")
        Course.create(number: "CS61C", title: "Computer Architecture")
        user.user_courses.create(number: "CS61B", title: "Data Structures")
        user.user_courses.create(number: "CS61A", title: "SICP")
        user.user_courses.create(number: "CS61C", title: "Computer Architecture")
        courses = User.find(1).courses()

        expect(courses.length).to be(3)
        expect(courses[0][:number]).to eq("CS61A")
        expect(courses[1][:number]).to eq("CS61B")
        expect(courses[2][:number]).to eq("CS61C")
      end
    end
  end
  describe '.has_taken' do
    before(:each) do
      User.destroy_all()
      Course.destroy_all()
      Course.create(number: "CS61A", title: "SICP")
      User.create(first_name: "John", last_name: "Doe", uid: "00000001", email: "john.doe@university.edu")
    end
    context 'user has not taken course' do
      it 'should return false' do
        user = User.find(1)
        course = Course.find(1)
        has_taken = user.has_taken(course)

        expect(has_taken).to eq(false)
      end
    end
    context 'user has taken course' do
      it 'should return true' do
        user = User.find(1)
        user.user_courses.create(number: "CS61A", title: "SICP")
        course = Course.find(1)
        has_taken = user.has_taken(course)

        expect(has_taken).to eq(true)
      end
    end
  end
end
