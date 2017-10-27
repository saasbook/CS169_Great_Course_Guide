Feature: Recommendation Cutoff

  As a student,
  So that I know the best courses.
  I should NOT be recommended courses with professor ratings lower than courses I'm already interested in.
  
Background: I have classes with previous professor ratings

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
  | name | category |
  | Cup  | EECS     |
  | Dog  | EECS     |
  | Cat  | EECS     |
  And the following courses were taught:
  | professor | number | rating | term |
  | Cup       | CS61A  | 5.6    | SP13 |
  | Cup       | CS61B  | 6.2    | SP15 |
  | Dog       | CS61C  | 4.7    | SP13 |
  | Cat       | CS70   | 6.5    | SP14 |
  And I am on the welcome page
  And I login as "Michael"
  And professors teach the appropriate courses
  Given I have "CS61A-choice" in my classes
  And I am on the courses page
  
Scenario: Displays better alternative classes to take in the future
  Given the following courses are going to be taught:
  | title | number | term       | professor |
  | EFGH  | CS61B  | FA16       | Cup       |
  | IJKL  | CS61C  | FA16       | Dog       |
  | MNOP  | CS70   | FA16       | Cat       |
  When I follow "Schedule"
  Then I should see "Courses You're Interested In" before "CS61B"
  Then I should see "Cup"
  And I should not see "CS61B" before "Best Alternative Courses"
  Then I should see "Best Alternative Courses" before "CS70"
  And I should not see "CS61C"