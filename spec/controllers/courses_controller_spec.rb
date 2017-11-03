require "spec_helper"
require "rails_helper"

describe CoursesController do

  User.destroy_all
  Professor.destroy_all
  Course.destroy_all

  CASClient::Frameworks::Rails::Filter.fake("123456")

  describe "Getting a specific class" do
    before :each do
      User.destroy_all
      Course.destroy_all
      @user = User.create(first_name: "Test", last_name: "Test", uid: "123456", email: "Test@test.test")
      @course = Course.create(number: "CS61A", title: "SICP")
    end
    it "should assign the correct course to @course" do
      get :show, id: @course.id
      expect(assigns(:course)).to eq(@course)
    end
    it "should assign @prereqs" do
      get :show, id: @course.id
      expect(assigns(:prereqs).nil?).to eq(@course.compute_prereqs_given_user(@user)[0].empty?)
    end
  end
  
  describe "Showing better alternative classes" do
    before :each do
      Professor.destroy_all
      UserCourse.destroy_all
      ProfessorCourse.destroy_all
      User.destroy_all
      Course.destroy_all
      Prereq.destroy_all

      @user = User.create(first_name: "John", last_name: "Doe", uid: "000", email: "jd@jd.com")
      @user.user_courses.create(number: "A", title: "TestA", taken: true)
      @user.user_courses.create(number: "B", title: "TestB", taken: true)
      @user.user_courses.create(number: "C", title: "TestC", taken: false)

      @a = Course.create(number: "A", title: "TestA")
      @b = Course.create(number: "B", title: "TestB")
      @b.prereqs.create(number: "A")
      @c = Course.create(number: "C", title: "TestC")
      @c.prereqs.create(number: "A")
      @c.prereqs.create(number: "B")
      @d = Course.create(number: "D", title: "TestD")
      @d.prereqs.create(number: "C")

      @prof1 = Professor.create(name: "Prof1")
      @prof1.professor_courses.create(number: "A", name: "TestA", rating: 5.5, term: "Fall 2014")
      @prof1.professor_courses.create(number: "B", name: "TestB", rating: 5.5, term: "Spring 2015")
      @prof2 = Professor.create(name: "Prof2")
      @prof2.professor_courses.create(number: "A", name: "TestA", rating: 7.0, term: "Spring 2015")
      @prof3 = Professor.create(name: "Prof3")
      @prof3.professor_courses.create(number: "C", name: "TestC", rating: 2.5, term: "Spring 2014")
      @prof3.professor_courses.create(number: "D", name: "TestD", rating: 1.5, term: "Fall 2014")
    end
    
    context "accessing the schedule page" do
      it "should load the page" do
        get :schedule
        expect(response).to render_template :schedule
      end
    end
  end
end
