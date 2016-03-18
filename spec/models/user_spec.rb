require "spec_helper"
require "rails_helper"

describe "User CRUD" do 
    #want a list of users
    before(:each) do
        User.destroy_all()
    end
    
    #create the user
    context "create the user" do
        it "should add the created user to the table" do 
            User.create(:first_name => "John", :last_name => "Doe",
                :email => "jd@berkeley.edu" , :uid => "25403252" )
            expect(User.find_by(:email => "jd@berkeley.edu").last_name).to eq ("Doe")
        end
        
        it "should reject a user with same uid" do 
            User.create(:first_name => "John", :last_name => "Doe",
                :email => "jd@berkeley.edu" , :uid => "25403252" )
            expect(User.new(:first_name => "Jon", :last_name => "Doh",
            :email => "jdd@berkeley.edu", :uid => "25403252")).to_not be_valid
            
        end
        
        it "should reject a user with same email" do 
            User.create(:first_name => "John", :last_name => "Doe",
                :email => "jd@berkeley.edu" , :uid => "25403252" )
            expect(User.new(:first_name => "Jon", :last_name => "Doh",
            :email => "jd@berkeley.edu", :uid => "65403262")).to_not be_valid
        end
        
        it "should add a user with the same name" do
            User.create(:first_name => "John", :last_name => "Doe",
                :email => "jd@berkeley.edu" , :uid => "25403252" )
            expect(User.create(:first_name => "Jon", :last_name => "Doh",
            :email => "jdd@berkeley.edu", :uid => "65403262")).to be_valid
        end
        
        it "should reject users with missing values" do 
             expect(User.create(:last_name => "Doh",
            :email => "jd@berkeley.edu", :uid => "65403262")).to_not be_valid
             
             expect(User.create(:first_name => "Jon",
            :email => "jd@berkeley.edu", :uid => "65403262")).to_not be_valid
             
             expect(User.create(:first_name => "Jon", :last_name => "Doh",
             :uid => "65403262" )).to_not be_valid
             
             expect(User.create(:first_name => "Jon", :last_name => "Doh",
            :email => "jd@berkeley.edu")).to_not be_valid
        end
        
    end
    context "update the user" do 
        it "shoud update the user if they already exist" do
            User.create(:first_name => "John", :last_name => "Doe",
                :email => "jd@berkeley.edu" , :uid => "25403252" )
            user = User.find_by(:uid => "25403252")
            expect(user.first_name).to eq("John")
            user.first_name = "James"
            user.save
            user = User.find_by(:uid => "25403252")
            expect(user.first_name).to eq("James")
        end
    end
    context "delete the user" do
        it "should delete a user that already exists" do
            User.create(:first_name => "John", :last_name => "Doe",
                :email => "jd@berkeley.edu" , :uid => "25403252" )
            user = User.find_by(:uid => "25403252")
            expect(user.first_name).to eq("John")
            user.delete
            user = User.find_by(:uid => "25403252")
            expect(user).to eq(nil)
        end
    end
    
    context "read the user" do
       it "should return nil if a user is not in the model" do
           user = User.find_by(:uid => "00001")
           expect(user).to eq(nil)
       end
       
       it "should return the user if they are in the model" do
           User.create(:first_name => "John", :last_name => "Doe",
                :email => "jd@berkeley.edu" , :uid => "25403252" )
            user = User.find_by(:uid => "25403252")
            expect(user.first_name).to eq("John")
        end
    end
end

describe "get all the emails" do
    context "there are users with emails" do 
        it "should get all of the emails" do 
             User.create(:first_name => "John", :last_name => "Doe",
                :email => "jd@berkeley.edu" , :uid => "25403252" )
             User.create(:first_name => "Jon", :last_name => "Doh",
            :email => "jdd@berkeley.edu", :uid => "65403262" )
            expect(User.all_emails).to include("jdd@berkeley.edu")
        end
    end
end

describe "get all the user courses" do 
    it "should not get any courses if the user has no courses" do 
        User.create(:first_name => "Jon", :last_name => "Doh",
                :email => "jdd@berkeley.edu", :uid => "65403262")
        user = User.find_by(:uid => "65403262")
        expect(user.courses).to be_empty
    end
    
    it "should get all of the users courses" do
        Course.create(:number => "CS61A", :title => "Structure and Interpretation")
        course1 = Course.find_by(:number => "CS61A") 
        User.create(:first_name => "Jon", :last_name => "Doh",
                :email => "jdd@berkeley.edu", :uid => "65403262")
        user = User.find_by(:uid => "65403262")
        user.user_courses.create(number: "CS61A", title: "Structure and Interpretation")
        expect(user.courses).to_not be_empty
        user.save
        
    end
    
    it "should have all of the courses in alphabetical order" do
        Course.create(:number => "CS61A", :title => "Interpretation")
        Course.create(:number => "CS61B", :title => "Structure")
        Course.create(:number => "CS61C", :title => "Structure and Interpretation")
        User.create(:first_name => "John", :last_name => "Doe",
                :email => "jd@berkeley.edu" , :uid => "25403252" )
              
        user = User.find_by(:uid => "25403252")
        user.user_courses.create(number: "CS61A", title: "Interpretation")
        user.user_courses.create(number: "CS61B", title: "Structure")
        user.user_courses.create(number: "CS61C", title: "Structure and Interpretation")
        expect(user.courses[0][:number]).to eq("CS61A")
        expect(user.courses[1][:number]).to eq("CS61B")
        expect(user.courses[2][:number]).to eq("CS61C")
        expect(user.courses.length).to eq(3)
    end
end