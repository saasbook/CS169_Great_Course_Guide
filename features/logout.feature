Feature: Logout of Calnet

  As a student
  So my data does not get hijacked
  I want to log out of my Calnet

Background: I am on the user page

  Given I am on the welcome page
  And I fill in "First Name" with "Michael"
  And I fill in "Last Name" with "Jackson"
  And I fill in "Email" with "mjhomie@gmail.com"
  And I press "Continue"
  Then there should be the button "Add Class"
  And I press "Finish"
  Then I should be on the user page

 Scenario: I click on the logout button
  Given I am on the user page
  Then I should see "Your Classes"
  And I click "Logout"


