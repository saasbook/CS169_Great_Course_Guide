Feature: Schedule Planning for Humanities

  As a user
  So that I can plan my humanities courses for the next year
  I would like to see a list of upcoming humanities courses taught by Distinguished Teachers

Background: I am on the user page

  Given I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page
  Given the following professors exist:
  | name       | distinguished | distinguishedYear | category |
  | Junko Habu | true			     | 2016              | HUM      |
  | Xin Liu    | false         | null              | HUM      |
  | Fae M. Ng  | true		       | 2014              | HUM      |
  And they teach the humanities classes


Scenario: I want to see classes taught by distinguished humanities teachers 

  When I follow "Schedule"
  Then I should see "Breadth"
  And I should see "ANTHROC125A"
  And I should not see "ANTHRO189"
  But I should see "ASAMST172"

Scenario: There are no distinguished humanities teachers teaching the next year (SAD PATH)

  Given "Junko Habu" isn't teaching "ANTHROC125A" next semester
  And "Fae M. Ng" isn't teaching "ASAMST172" next semester
  When I follow "Schedule"
  And I should not see "Junko"
  And I should not see "Xin"
  And I should not see "Fae"
  But I should see "No classes taught by a distinguished humanities professor the next semester."
  And I should see "Please see your advisor for more details."