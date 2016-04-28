Feature: Add Courses

  As a student
  So that I can consider my course options
  I should be able to add/delete courses from my home page

Background: I am on the user page

  Given I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page
  Given the following courses exist:
  | title                   | number      |
  | ABCD                    | CS61A       |
  | EFGH                    | CS61B       |
  | IJKL                    | CS61C       |

Scenario: Click All Courses
  When I follow "Courses"
  Then I should be on the courses page
  Then I should see "CS61A"
  Then I should see "CS61B"
  And I should not see "IJKL" before "EFGH"
  But I should see "ABCD" before "CS61C"
  When I follow "Back"
  Then I should be on the user page

Scenario: Add Courses I Have Taken
  When I follow "Edit"
  Then I should be on the edit page
  When I check "#CS61A-taken"
  And I check "#CS61A-choice"
  When I check "#CS61B-taken"
  And I check "#CS61B-choice"
  Then I press "#save"
  Then I should be on the user page
  And I should see "CS61A" before "CS61B"
  And I should not see "EFGH" before "Courses You Want to Take"
  And I should not see "CS61B" before "Your Completed Courses"

Scenario: Delete Courses
  Given I have "CS61A-choice" in my classes
  Given I have "CS61B-choice" in my classes
  When I follow "Edit"
  When I uncheck "#CS61A-choice"
  And I check "#CS61C-choice"
  Then I press "#save"
  And I should not see "CS61A"
  And I should not see "CS61B" before "Courses You Want to Take"
  And I should see "CS61C" before "Your Completed Courses"
