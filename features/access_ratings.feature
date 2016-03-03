Feature: Access Teacher's Ratings

  As a student
  So that I can pick my teachers
  I should be able to retrieve a list of the best teachers

Background: I am on the user page

  Given I am on the welcome page
  And I fill in "First Name" with "Michael"
  And I fill in "Last Name" with "Jackson"
  And I fill in "Email" with "mjhomie@gmail.com"
  And I press "Continue"
  Then there should be the button "Add Class"
  And I press "Finish"
  Then I should be on the user page
  Given the following professors exist:
  | name                    | rating   | 
  | Dog                     | 7.0      | 
  | Cup                     | 4.0      | 
  | Cat                     | 2.0      |

Scenario: I press on the Professors Page

  Given I am on the user page
  When I follow "Professors"
  Then I should see "All Professors"
  Then I should see "Dog" before "Cat"
  And I should see "Cup" before "Cat"
  But I should not see "Cup" before "Dog"