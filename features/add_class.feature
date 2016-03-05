Feature: Add Classes

  As a student
  So that I can consider my course options
  I should be able to add/delete courses from my home page

Background: I am on the user page

  Given I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page
  Given the following courses exist:
  | title                   | number          | 
  | ABCD                    | CS61A           | 
  | EFGH                    | CS61B           | 
  | IJKL                    | CS61C           |

Scenario: Click All Classes
  When I follow "Classes"
  Then I should be on the classes page
  Then I should see "CS61A"
  Then I should see "CS61B"
  And I should not see "IJKL" before "EFGH"
  But I should see "ABCD" before "CS61C"
  When I follow "Back"
  Then I should be on the user page

Scenario: Add Classes
  When I follow "Edit"
  Then I should be on the edit page
  When I check "CS61A-choice"
  And I check "CS61B-choice"
  Then I press "Save"
  Then I should be on the user page
  And I should see "CS61A"
  And I should see "EFGH"

Scenario: Delete Classes
  Given I have "CS61A-choice" in my classes
  Given I have "CS61B-choice" in my classes
  When I follow "Edit"
  When I uncheck "CS61A-choice"
  And I check "CS61C-choice"
  Then I press "Save"
  And I should not see "CS61A"
  And I should see "CS61B"
  And I should see "CS61C"
