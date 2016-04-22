Feature: Add Classes to Fall Schedule

  As a student
  So that I can plan out my next semester of EECS courses
  I should be able to select classes that I want to take next semester

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
Scenario: Adding a class and removing a class
  Given the following courses are going to be taught:
  | title | number | term       | professor |
  | EFGH  | CS61B  | FA16       | Cup       |
  When I check "add-CS61B"
  Then "add-CS61B" should be checked
  When I uncheck "add-CS61B"
  Then "add-CS61B" should not be checked
