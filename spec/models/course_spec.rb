require "rails_helper"

describe "Prereqs for courses"  do
    context "If the prereq does not exist as a course" do
        it 'should not include the prereq if the prereq is not in the database' do
            # setup
            user = User.new(:first_name =>"John", :last_name => "Doe", 
                :email =>"JohnDoe@berkeley.edu" , :uid => "23152");
            bad_course = Course.new(:number => "MATH180", :title => "Math")
            
            course = Course.new(:number => "CS22" , :title => "Fake CS course" , :prereq => bad_course) 

            # exercise
            requirements = course.compute_prereqs_given_user(user)
            
            # verify
            expect(requirements).not_to include[bad_course.number]
        end
    end
    context "If the prereq does exist" do
        it 'should return a list of reqs that include the course' do
           # setup
            user = User.new(:first_name =>"John", :last_name => "Doe", 
                :email =>"JohnDoe@berkeley.edu" , :uid => "23152")
            good_course = Course.find_by(:number => "CS61A")
            course = Course.new(:number => "CS22" , :title => "Fake CS course" , :prereq => bad_course) 
            # exercise
            requirements = course.compute_prereqs_given_user(user)
            
            # verify
            expect(requirements).not_to include [good_course.number]
        end
    end
end

describe "user has taken the prereqs for the course already" do 
    it 'should not show the course in the list of requirements' do
        # setup
        completed_course = Course.find_by(:number => "CS61A")
        user = User.new(:first_name =>"John", :last_name => "Doe", 
                :email =>"JohnDoe@berkeley.edu" , :uid => "23152", :user_courses => completed_course)
        
        course = Course.new(:number => "CS22" , :title => "Fake CS course" , :prereq => bad_course) 
        # exercise
        requirements = course.compute_prereqs_given_user(user)
        # verify
        expect(requirements).not_to include [completed_course.number]
    end
end
