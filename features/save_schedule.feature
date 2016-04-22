Feature: Add Classes to Schedule

  As a student
  So that I can plan out my next semester of EECS courses
  I should be able to select classes that I want to take next semester

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
