Feature: Show Ratings by Course

  As a student
  So that I can determine who is the best teacher to take a course under
  I would like to see each professor's rating by course

Background: Professors teach courses and get ratings

  Given the following courses exist:
  | title | number |
  | ABCD  | CS61A  |
  | EFGH  | CS61B  |
  | IJKL  | CS61C  |
  And the following professors exist:
  | name | category |
  | Cup  | EECS     |
  And the following courses were taught:
  | professor | number | rating | term |
  | Cup       | CS61A  | 5.6    | SP13 |
  | Cup       | CS61A  | 3.5    | SP14 |
  | Cup       | CS61A  | 6.2    | SP15 |
  | Cup       | CS61B  | 4.1    | SP13 |
  | Cup       | CS61B  | 5.5    | SP14 |
  And I am on the welcome page
  And I login as "Michael"
  And I am on the professors page

Scenario: Professor page displays overall rating
  When I follow "Cup"
  Then I should see "Overall" before "4.98"

Scenario: Professor page displays average rating for courses
  When I follow "Cup"
  Then I should see "CS61A" before "5.10"
  And I should see "CS61B" before "4.80"

Scenario: Professor page does not display ratings for courses professor does not teach
  When I follow "Cup"
  Then I should not see "CS61C"
