Feature: Access Teacher's Ratings

  As a student
  So that I can pick my teachers
  I should be able to retrieve a list of the best teachers

Background: I am on the user page

  Given I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page
  Given the following professors exist:
  | name                    | rating   | 
  | Cup                     | 4.0      | 
  | Dog                     | 7.0      | 
  | Cat                     | 2.0      |

Scenario: I press on the Professors Page

  When I follow "Professors"
  Then I should see "All Professors"
  Then I should see "Dog" before "Cat"
  And I should see "Cup" before "Cat"
  But I should not see "Cup" before "Dog"