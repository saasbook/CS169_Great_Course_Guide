Feature: See Updated Spring Recommendations

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

@wip
Scenario: Displays spring classes 
  Given the following courses are going to be taught:
  | title | number | term       | professor |
  | EFGH  | CS61B  | FA16       | Cup       |
  | IEFJ  | CS61B  | SP17       | Dog       |
  When I follow "Schedule"
  When I check "add-CS61B"
  Then "#CS61B-spring" should not be visible 
  And I should not see "Dog"

@wip
Scenario: No classes to remove in Spring
  Given the following courses are going to be taught:
  | title | number | term       | professor |
  | EFGH  | CS61B  | FA16       | Cup       |
  When I check "add-CS61B"
  And I uncheck "add-CS61B"
  Then I should not see "#CS61B-spring"
  













