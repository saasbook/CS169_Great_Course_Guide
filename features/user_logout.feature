Feature: Logout of Calnet

  As a student
  So my data does not get hijacked
  I want to log out of my Calnet

Background: I am on the user page

  Given I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page

 Scenario: Logout button exists
  Given I am on the user page
  Then I should see "Logout"
  Then I logout