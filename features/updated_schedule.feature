Feature: Spring Semester Updated

  As a student
  So that I can plan out my Spring of EECS courses
  I should be able to see an updated Spring schedule based on my Fall choices

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
