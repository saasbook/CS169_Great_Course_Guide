Feature: User Login with Calnet

  As a student
  So that I can access my account
  I want to login through Calnet

Scenario: I click the login button
  Given I am on the home page
  Then I follow "Login"
  Then I should be on the welcome page
  And I should see "First Name"
  And I should see "Last Name"
  And I should see "Email"

Scenario: Enter information on Welcome Page
  Given I am on the welcome page
  And I fill in "First Name" with "Michael"
  And I fill in "Last Name" with "Jackson"
  And I fill in "Email" with "mjhomie@gmail.com"
  And I press "Continue"
  Then there should be the button "Add Class"
  And I press "Finish"
  Then I should be on the user page
  

