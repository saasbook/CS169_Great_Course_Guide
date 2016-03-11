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

  describe "create" do
    before :each do
      User.destroy_all
      Course.destroy_all
      Course.create(number: "CS61A", title: "SICP")
    end
    it "should create and store a new user in @user if the user has a unique email and uid" do
      first_user = {first_name: "Test", last_name: "Test", uid: "123456", email: "unique@test.test", class_select: ["CS61A: SICP"]}
      post :create, first_user
      expect(assigns(:user)).to eq(User.find_by(uid: first_user[:uid]))
    end
    it "should not create and store a new user if the user has an email or uid already" do
      first_user = {first_name: "Test", last_name: "Test", uid: "123456", email: "unique@test.test"}
      invalid_uid_user = {first_name: "Test", last_name: "Test", uid: "123456", email: "notunique@test.test"}
      post :create, invalid_uid_user
      expect(assigns(:user)).to eq(User.find_by(uid: first_user[:uid]))
    end
    it "should add classes take by the user to @user.user_courses" do
      first_user = {first_name: "Test", last_name: "Test", uid: "123456", email: "unique@test.test", class_select: ["CS61A: SICP"]}
      post :create, first_user
      expect(assigns(:user).user_courses.first.number).to eq("CS61A")
    end
  end

  describe "edit" do
    before :each do
      User.destroy_all
      Course.destroy_all
      @course = Course.create(number: "CS61A", title: "SICP")
      @user = User.create(first_name: "Test", last_name: "Test", uid: "123456", email: "Test@test.test")
      @user.user_courses.create(number: "CS61A", title: "SICP")
    end
    it "should add all user course names to @user_classNames" do
      get :edit
      expect(assigns(:user_classNames)).to include(@course.number)
    end
  end

  describe "update" do
    before :each do
      User.destroy_all
      Course.destroy_all
      @user = User.create(first_name: "Test", last_name: "Test", uid: "123456", email: "Test@test.test")
      @course = Course.create(number: "CS61A", title: "SICP")
    end
    it "should update @user.user_courses with :classes" do
      class_dict = {classes: {"CS61A: SICP": true}}
      post :update, class_dict
      expect(assigns(:user).user_courses.first.title).to eq(@course.title)
    end    
  end

  it "logging out" do
    get :logout
  end
end
