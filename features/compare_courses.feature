Feature: Compare courses and their info from
    As a student,
    So that I can compare courses by semester
    I should see a table with the HKN professor rating
        course rating specific to the professor
        difficulty rating, and number of units

Background: the following courses are comparable
    
  Given the following courses exist:
  | title | number | units |
  | ABCD  | CS61A  | 4     |
  | EFGH  | CS61B  | 4     |
  | IJKL  | CS61C  | 4     |
  | Fork  | Spoon  | 4     |
  And the following professors exist:
  | name | category |
  | Cup  | EECS     |
  | Tea  | EECS     |
  And the following courses were taught:
  | professor | number | rating | 
  | Cup       | CS61A  | 5.6    | 
  | Tea       | CS61A  | 3.5    | 
  | Cup       | CS61B  | 6.2    | 

Scenario: Adding classes to compare
  When I press "Select Course"
  And I press "CS61A"
  And I press "Select Professor (optional)"
  And I press "Cup"
  And I press "Add"
  Then I should see "CS61A" before "4"
  And I should see "4" before "Cup" 
  And I should see "Cup" before "5.9"
  And I should see "5.9" before "5.6"
  
  When I press "Select Course"
  And I press "CS61A"
  And I press "Select Professor (optional)"
  And I press "Tea"
  And I press "Add"
  Then I should see "CS61A" before "4 units"
  And I should see "4" before "Tea" 
  And I should see "Tea" before "3.5" 
  And I should see "3.5" before "3.5"
  
Scenario: Removing a class
  When I press "Select Course"
  And I press "CS61A"
  And I press "Select Professor (optional)"
  And I press "Cup"
  And I press "Add"
  And I press "Remove"
  Then I should not see "CS61A"
  And I should not see "4"
  And I should not see "Cup"
  And I should not see "5.9"
  And I should not see "5.6"
  
Scenario: Adding a class without specifying a professor
  When I press "Select Course"
  And I press "CS61B"
  And I press "Add"
  Then I should see "CS61B" before "4"
  And I should see "4" before "Cup"
  And I should see "Cup" before "5.9" 
  And I should see "5.9" before "5.6" 

Scenario: User doesn't specify course
  When I press "Select Professor (optional)"
  And I press "Cup"
  And I press "Add"
  Then I should not see "CS61B"