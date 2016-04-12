Feature: Show Details about Specific Class

  As a Student
  So that I can take classes I am ready for
  I want to see prerequisite and professor details about a specific class

Background: I have classes

  Given the following courses exist:
  | title | number |
  | ABCD  | CS61A  |
  | EFGH  | CS61B  |
  | IJKL  | CS61C  |
  | MNOP  | CS70   |
  And the following prerequisites exist:
  | course | number |
  | CS61C  | CS61B  | 
  | CS61B  | CS61A  |
  | CS70   | CS61B  | 
  | CS70   | CS61A  | 
  And the following professors exist:
  | name |
  | Cup  | 
  | Dog  | 
  | Cat  | 
  And I am on the welcome page
  And I login as "Michael"
  And professors teach the appropriate courses
  Then I should be on the user page

Scenario: Prerequisites show

  Given I am on the courses page
  When I follow "CS61C"
  Then I should see "Required Prerequisites"
  And I should see "CS61B"
  But I should not see "CS70"

Scenario: Prerequisite links work

  Given I am on the courses page
  When I follow "CS61C"
  Then I should see "Required Prerequisites"
  When I follow "CS61B"
  Then I should see "Required Prerequisites"
  When I follow "CS61A"
  Then I should see "Required Prerequisites"
  But I should not see "CS61B"

Scenario: Accounts for taken classes

  Given I am on the user page
  And I have "CS61A-choice" in my classes
  When I am on the courses page
  And I follow "CS70"
  Then I should see "Required Prerequisites"
  And I should see "CS61B" before "CS61A"
  And I should not see "Yes" before "CS61A"
  And I should see "No" before "CS61A"

Scenario: Shows all professors that have taught a certain course
  Given I am on the courses page
  And I follow "CS61A"
  Then I should see "Cat"
  And I should see "Cup"
  But I should not see "Dog"





