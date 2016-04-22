Feature: Spring Semester Updated

  As a student
  So that I can plan out my Spring of EECS courses
  I should be able to see an updated Spring schedule based on my Fall choices

Background: I have classes

  Given the following courses exist:
  | title | number |
  | ABCD  | CS61A  |
  | EFGH  | CS61B  |
  | IJKL  | CS61C  |
  | MNOP  | CS70   |
  | Fork  | Spoon  |
  | ESPN  | CS188  |
  And the following prerequisites exist:
  | course | number |
  | CS188  | CS61B  |
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

Scenario: Displays spring classes 
  Given the following courses are going to be taught:
  | title | number | term       | professor |
  | EFGH  | CS61B  | FA16       | Cup       |
  When I follow "Schedule"
  Then I should see "Courses You're Interested In" before "CS61B"
  Then I should see "Cup"
  And I should not see "CS61B" before "Best Alternative Courses"

Scenario: The user isn't eligible to take any classes in the upcoming year (sad path)
  Given the following courses are going to be taught:
  | title | number | term       | professor |
  | MNOP  | CS70   | FA18       | Cat       |
  | ESPN  | CS188  | FA16       | Cup       |
  When I follow "Schedule"
  Then I should see "Courses You're Interested In"
  Then I should see "It seems you cannot take any classes offered next semester."
  Then I should see "Please go see your advisor."

Scenario: The classes the user wants to take don't match what they can take (sad path)
  Given the following courses are going to be taught:
  | title | number | term       | professor |
  | EFGH  | CS61B  | FA16       | Cup       |
  Given I am on the user page
  Given I want to take "CS61C-choice"
  When I follow "Schedule"
  Then I should see "Courses You're Interested In"
  Then I should see "CS61B"
  And I should not see "CS61C"
