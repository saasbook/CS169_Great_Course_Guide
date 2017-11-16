require "spec_helper"
require "rails_helper"

describe UserCoursesController do

  CASClient::Frameworks::Rails::Filter.fake("123456")

  describe "create" do
    before :each do
      User.destroy_all
      Course.destroy_all
      UserCourse.destroy_all
      @course = Course.create(number: "CS61A", title: "SICP")
      @user = User.create(first_name: "Test", last_name: "Test", uid: "123456", email: "Test@test.test")
      @user.user_courses.create(number: "CS61B", title: "DS")
    end
    it "creates taken user course" do
      expect{ 
        post :create, :course => "CS61A: SICP", :taken => true
     }.to change(UserCourse, :count).by(1)
    end
    it "creates interested user course" do
      expect{ 
        post :create, :course => "CS61A: SICP", :taken => false
     }.to change(UserCourse, :count).by(1)
    end
  end

  describe "destroy" do
    before :each do
      User.destroy_all
      Course.destroy_all
      @course = Course.create(number: "CS61A", title: "SICP")
      @user = User.create(first_name: "Test", last_name: "Test", uid: "123456", email: "Test@test.test")
      @user_course = @user.user_courses.create(number: "CS61A", title: "SICP")
    end
    it "deletes the user course" do
      expect{ 
        delete :destroy, :id => @user_course
     }.to change(UserCourse, :count).by(-1)
    end
  end
end