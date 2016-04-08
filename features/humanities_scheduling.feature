Feature: Schedule Planning for Humanities

  As a user
  So that I can plan my humanities courses for the next year
  I would like to see a list of upcoming humanities courses taught by Distinguished Teachers

Background: I am on the user page

  Given I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page
  Given the following professors exist:
  | name | distinguished | distinguishedYear |
  | Cup  | true			     | 2016              |
  | Dog  | false         | null              |
  | Cat  | false		     | null              |

Scenario: I want to see classes taught by distinguished humanities teachers 

  When I follow "Recommended Schedule"
  Then I should see "Humanities"
  And I should see "CS61A"
  And I should see "CS61B"
  But I should not see "CS61C"

Scenario: There are no distinguished humanities teachers teaching the next year (SAD PATH)

  When I follow "Recommended Schedule"
  Then I should see "Humanities"
  And I should not see "CS61A"
  And I should not see "CS61B"
  And I should not see "CS61C"
  But I should see "No classes taught by a distinguished humanities professor the next year :("
  And I should see "Please see your advisor for more details."