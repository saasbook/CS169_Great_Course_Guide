Feature: An about page for visitors and existing users to learn more about The Great Course Guide
    As a student,
    So I understand the purpose of the Great Professor Guide,
    I should see the About page,
    which details use cases and relevant metrics.
    
Scenario: User is not logged in 
  Given I am on the home page
  Then I should see "Login"
  And I should see "Our Purpose"
  And I should see "Who We Are"
  
Scenario: User is logged in 
  Given I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page
  When I follow "About"
  Then I should be about in the url
  And I should see "Our Purpose"
  And I should see "Who We Are"