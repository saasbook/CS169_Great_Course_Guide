Feature: Number of Units For a Course

  As a student
  So I can make sure I am taking enough units
  I would like to see the number of units for each course

Background: I am on the courses page

  Given I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page
  Given the following courses exist:
  | title                   | number      | units |
  | ABCD                    | CS61A       | 4     |
  | EFGH                    | CS61B       | 4     |
  | IJKL                    | EE61C       | 3     |
  | MNOP                    | EE198       | 2     |
  | YOYO                    | CS150       | nil   |
  Then I follow "All Courses"

Scenario: Checking Units on All Courses Page
  Then I should see "4 Units"
  Then I should not see "1 Unit"
  Then I should not see "5 Units"
  Then I should see "3 Units"
  Then I should see "2 Units"

Scenario: Units on Specific Course Page
  When I follow "CS61A"
  Then I should see "4 Units"
  Then I should not see "3 Units"
  Then I should not see "2 Units"

Scenario: Units do not exist for specific course
  When I follow "YOYO"
  Then I should see "units info not available"
