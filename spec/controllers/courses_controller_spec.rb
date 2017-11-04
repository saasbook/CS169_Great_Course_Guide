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
    it "should load the schedule page" do
      get :schedule
      expect(response).to render_template :schedule
    end
  end
  
  describe "Showing better alternative classes" do
    before :each do
      User.destroy_all
      Course.destroy_all
      Professor.destroy_all
      UserCourse.destroy_all
      ProfessorCourse.destroy_all
      @user = User.create(first_name: "Test", last_name: "Test", uid: "123456", email: "Test@test.test")
      @a = Course.create(number: "A", title: "TestA")
      @b = Course.create(number: "B", title: "TestB")
      @c = Course.create(number: "C", title: "TestC")
      @prof1 = Professor.create(name: "Prof1")
      @prof2 = Professor.create(name: "Prof2")
      @prof3 = Professor.create(name: "Prof3")
      @prof1.professor_courses.create(number: "A", name: "TestA", rating: 4.0, term: "Spring 2016")
      @prof2.professor_courses.create(number: "B", name: "TestB", rating: 3.0, term: "Spring 2016")
      @prof3.professor_courses.create(number: "C", name: "TestC", rating: 7.0, term: "Spring 2016")
      @user.user_courses.create(number: "A", title: "TestA", taken: false)
      @user.user_courses.create(number: "B", title: "TestB", taken: false)
      @user.user_courses.create(number: "C", title: "TestC", taken: false)
      get :schedule
    end
    it "should load the schedule page" do
      expect(response).to render_template :schedule
    end
    it "should call recommended_EECS_courses" do
      expect(assigns(:recommended_EECS_courses)).to eq(@user.recommended_EECS_courses)
    end
    it "should have the correct rating threshold" do
      pending("need to indicate interested courses")
      fail
    end
    it "should contain better alternative courses" do
      pending("implement rspec for better")
      fail
    end
    it "should not contain worse alternative courses" do
      pending("implement rspec for worse")
      fail
    end
  end
end
