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
end
