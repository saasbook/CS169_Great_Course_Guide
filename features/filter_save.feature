Feature: Filter Courses

  As a student
  So that I can easily see the kinds of classes that I am interested in on the course lists
  My filter preferences should be maintained throughout my session

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

Scenario: Uncheck EE then leave the page and come back
  Then ".CS_LOWER_DIV" should be visible
  Then ".CS_UPPER_DIV" should be visible
  Then ".EE_LOWER_DIV" should be visible
  Then ".EE_UPPER_DIV" should be visible
  When I uncheck "#ee"
  Then ".CS_LOWER_DIV" should be visible
  Then ".CS_UPPER_DIV" should be visible
  Then ".EE_LOWER_DIV" should not be visible
  Then ".EE_UPPER_DIV" should not be visible
  When I follow "CS61B"
  Then I follow "All Courses"
  Then ".CS_LOWER_DIV" should be visible
  Then ".CS_UPPER_DIV" should be visible
  Then ".EE_LOWER_DIV" should not be visible
  Then ".EE_UPPER_DIV" should not be visible

Scenario: Uncheck all options and come back
  When I uncheck "#cs"
  When I uncheck "#lower"
  When I uncheck "#upper"
  When I uncheck "#grad"
  Then ".CS_LOWER_DIV" should not be visible
  Then ".CS_UPPER_DIV" should not be visible
  Then ".EE_LOWER_DIV" should not be visible
  Then ".EE_UPPER_DIV" should not be visible
