Feature: Show Details about Specific Professor

  As a Student
  So that I can choose the best professor for my classes
  I want to see details about a specific professor and his/her classes

Background: I have classes

  Given the following courses exist:
  | title | number |
  | ABCD  | CS61A  |
  | EFGH  | CS61B  |
  | IJKL  | CS61C  |
  | MNOP  | CS70   |
  | Fork  | Spoon  |
  And the following professors exist:
  | name |
  | Cup  | 
  | Dog  | 
  | Cat  | 
  And I am on the welcome page
  And I login as "Michael"
  And professors teach the appropriate courses
  Given I have "CS61A-choice" in my classes
  And I am on the courses page


Scenario: Professor page displays correct info
  When I follow "CS61A"
  And I follow "Cup"
  Then I should see "Cup"
  And I should see "CS61B" before "Spoon"

Scenario: Clicking on a class should go to class page
  When I follow "CS61A"
  And I follow "Cup"
  Then I follow "CS61B"
  Then I should see "Required Prerequisites"