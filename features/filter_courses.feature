Feature: Filter Courses

  As a student
  So that I can limit the amount of courses to look through
  I would like to to filter the classes based on subject and upper/lower division

Background: I am on the courses page

  Given I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page
  Given the following courses exist:
  | title                   | number      |
  | ABCD                    | CS61A       |
  | EFGH                    | CS61B       |
  | IJKL                    | EE61C       |
  | MNOP                    | EE198       |
  | YOYO                    | CS150       |
  Then I follow "All Courses"

Scenario: Initially, everything is visible
  Then ".CS_LOWER_DIV" should be visible
  Then ".CS_UPPER_DIV" should be visible
  Then ".EE_LOWER_DIV" should be visible
  Then ".EE_UPPER_DIV" should be visible

Scenario: Filter by CS
  Then I should see "Upper Divs"
  And I should see "CS61A"
  When I uncheck "ee"
  Then ".CS_LOWER_DIV" should be visible
  Then ".CS_UPPER_DIV" should be visible
  Then ".EE_LOWER_DIV" should not be visible
  Then ".EE_UPPER_DIV" should not be visible

Scenario: Filter by EE
  When I uncheck "cs"
  Then ".CS_LOWER_DIV" should not be visible
  Then ".EE_LOWER_DIV" should be visible
  When I uncheck "upper"
  Then ".EE_UPPER_DIV" should not be visible
  Then ".EE_LOWER_DIV" should be visible

Scenario: Filter everything out (sad path)
  When I uncheck "cs"
  When I uncheck "ee"
  Then ".CS_LOWER_DIV" should not be visible
  Then ".CS_UPPER_DIV" should not be visible
  Then ".EE_LOWER_DIV" should not be visible
  Then ".EE_UPPER_DIV" should not be visible
