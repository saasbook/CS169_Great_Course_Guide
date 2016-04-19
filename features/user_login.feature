Feature: User Login with Calnet

  As a student
  So that I can access my account
  I want to login through Calnet

Scenario: I click the login button
  Given I am on the home page
  Then I follow "Login"
  Then I should be on the welcome page
  #And I should see "#first_name"
  #And I should see "#last_name"
  #And I should see "#email"

Scenario: Enter information on Welcome Page
  Given I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page
  

