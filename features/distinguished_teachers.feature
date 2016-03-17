Feature: Distinguished Teachers

  As a student
  So that I can take classes from the best teachers
  I want to see a list of teachers who won the distinguished teaching award.

Scenario: Seeing Distinguished Teachers
  Given I am on the welcome page
  And I login as "Michael"
  When I follow "Distinguished Teachers"
  I should see "Distinguished Teachers"
  I should see "John Denero"
  I should see "Josh Hug"
