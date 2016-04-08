Feature: Non-Major Requirements

  As a student
  So that I can plan my breadth requirements
  I would like to see a list non-major courses taught by distinguished teachers

Background: I am on the user page

  Given I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page
  Given the following professors exist:
  | name | distinguished | distinguishedYear |
  | Cup  | true			     | 2016              |
  | Dog  | false         | null              |
  | Cat  | false		     | null              |
  
Scenario: I see the distinguished humanities professor

  When I click on "Distinguished Professors"
  Then I should see "Humanities"
  Then I should see "Cup" after "Humanities"
  But I should not see "Dog"

Scenario: There are no distinguished humanities professors (SAD PATH)

  When I click on "Distinguished Professors"
  Then I should not see "Cup"
  And I should not see "Cat"