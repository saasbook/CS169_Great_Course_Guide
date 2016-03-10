require "spec_helper"
require "rails_helper"

describe ApplicationController do

  User.destroy_all
  Professor.destroy_all
  Course.destroy_all

  CASClient::Frameworks::Rails::Filter.fake("123456")

	describe "Requiring info" do
		it "should redirect to the welcome page" do
			get :index
			expect(response).to redirect_to '/welcome'
		end
    it "should not redirect if the user exists" do
      user = User.create(first_name: "Test", last_name: "Test", uid: "123456", email: "Test@test.test")
      get :index
      expect(response).to render_template(:index)
    end
	end

  describe "getting info" do
    before :each do
      User.destroy_all
      @user = User.create(first_name: "Test", last_name: "Test", uid: "123456", email: "Test@test.test")
    end
    it "should assign the user instance to @user" do
      get :index
      expect(assigns(:user)).to eq(@user)
    end
    it "should assign all courses to @all_courses" do
      Course.should_receive(:all_courses).and_return("test_course")
      get :index
      expect(assigns(:all_courses)).to eq("test_course")
    end
    it "should assign all professors to @all_professors" do
      Professor.should_receive(:all_profs).and_return("test_prof")
      get :index
      expect(assigns(:all_profs)).to eq("test_prof")
    end
    it "should assign all emails to @all_emails" do
      User.should_receive(:all_emails).and_return("test_email")
      get :index
      expect(assigns(:all_emails)).to eq("test_email")
    end
  end

  describe "welcome page" do
    it "should redirect to the user page if the user exists" do
      User.destroy_all
      @user = User.create(first_name: "Test", last_name: "Test", uid: "123456", email: "Test@test.test")
      get :welcome
      expect(response).to redirect_to "/user"
    end
    it "should render the welcome view if the user does not exsits" do
      User.destroy_all
      get :welcome
      expect(response).to render_template :welcome
    end
  end

  describe "Getting a specific class" do
    before :each do
      User.destroy_all
      Course.destroy_all
      @user = User.create(first_name: "Test", last_name: "Test", uid: "123456", email: "Test@test.test")
      @course = Course.create(number: "CS61A", title: "SICP")
    end
    it "should should assign the correct course to @course" do
      get :specific_class, id: @course.id
      expect(assigns(:course)).to eq(@course)
    end
    it "should assign @prereqs" do
      get :specific_class, id: @course.id
      expect(assigns(:prereqs)).to eq(@course.compute_prereqs_given_user(@user))
    end
  end

  # TODO
  describe "create" do
  end

  # TODO
  describe "edit" do
  end

  # TODO
  describe "update" do
  end

  it "logging out" do
    get :logout
  end
end
