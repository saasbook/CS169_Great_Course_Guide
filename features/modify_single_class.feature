Feature: Modify Single Class
	As a student,
	so that I can easily modify my interested or taken courses,
	I should be able to add and remove a single course from my user courses page.

Background: I am on the user page

  Given I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page
  Given the following courses exist:
  | title                   | number      |
  | ABCD                    | CS61A       |
  | Data Structures         | CS61B       |
  | IJKL                    | CS61C       |

Scenario: Add Single Interested Course
  When I fill in "interested-course-search" with "CS61B: Data Structures"
  And I press "#submit-interested-course"
  Then I should be on the user page
  And I should see "CS61B" before "Your Completed Courses"
  And I should not see "CS61B" after "Your Completed Courses"

Scenario: Add Single Taken Course
  When I fill in "taken-course-search" with "CS61B: Data Structures"
  And I press "#submit-taken-course"
  Then I should be on the user page
  And I should not see "CS61B" before "Your Completed Courses"
  And I should see "CS61B" after "Your Completed Courses"

Scenario: Add Single Taken Course From Interested Courses
  Given I want to take "CS61B-choice"
  When I fill in "taken-course-search" with "CS61B: Data Structures"
  And I press "#submit-taken-course"
  Then I should be on the user page
  And I should not see "CS61B" before "Your Completed Courses"
  And I should see "CS61B" after "Your Completed Courses"

Scenario: Remove Single Course
  Given I want to take "CS61B-choice"
  When I delete the course "CS61B" 
  Then I should be on the user page
  And I should not see "CS61B"
