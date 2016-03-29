Feature: Distinguished Teachers

  As a student
  So that I can take classes from the best teachers
  I want to see a list of teachers who won the distinguished teaching award.

Background: There are classes

  Given the following professors exist:
  | name | distinguished |
  | Cup  | true			     |
  | Dog  | true          |
  | Cat  | false		     |
  And I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page

Scenario: Seeing Distinguished Teachers
  When I follow "Distinguished Professors"
  And I should see "Dog"
  And I should see "Cup"
  And I should not see "Cat"

