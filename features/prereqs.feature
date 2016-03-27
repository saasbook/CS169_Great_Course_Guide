Feature: Factor in Prerequisites

  As a Student
  So that I can take classes I am ready for
  I want to see classes I have the prerequisites for

Background: I have classes

  Given the following courses exist:
  | title | number |
  | ABCD  | CS61A  |
  | EFGH  | CS61B  |
  | IJKL  | CS61C  |
  | MNOP  | CS70   |
  And the following prerequisites exist:
  | course | number | title |
  | CS61C  | CS61B  | EFGH  |
  | CS61B  | CS61A  | ABCD  |
  | CS70   | CS61B  | EFGH  |
  | CS70   | CS61A  | ABCD  |
  And I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page

Scenario: Prerequisites show

  Given I am on the classes page
  When I follow "CS61C"
  Then I should see "Prerequisites for CS61C"
  And I should see "CS61B"
  But I should not see "CS70"

Scenario: Prerequisite links work

  Given I am on the classes page
  When I follow "CS61C"
  Then I should see "Prerequisites for CS61C"
  When I follow "CS61B"
  Then I should see "Prerequisites for CS61B"
  When I follow "CS61A"
  Then I should see "Prerequisites for CS61A"
  But I should not see "CS61B"

Scenario: Accounts for taken classes

  Given I am on the user page
  And I have "CS61A-choice" in my classes
  When I am on the classes page
  And I follow "CS70"
  Then I should see "Prerequisites for CS70"
  And I should see "CS61B" before "Completed Prerequisites"
  And I should not see "CS61A" before "Completed Prerequisites"

Scenario: Prereqs in proper category (taken vs remaining)
  Given I am on the user page
  And I have "CS61A-choice" in my classes
  When I am on the classes page
  And I follow "CS61B"
  Then I should see "Completed Prerequisites" before "CS61A" 






