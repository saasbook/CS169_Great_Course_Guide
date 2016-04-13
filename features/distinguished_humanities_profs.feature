Feature: Distinguished Humanities Professors

  As a student
  So that I can know the award-winning non-EECS professors
  I would like to which humanities professors have won the award

Background: I am on the user page

  Given I am on the welcome page
  And I login as "Michael"
  Then I should be on the user page
  
Scenario: I see the distinguished humanities professor

  Given the following professors exist:
  | name | distinguished | distinguishedYear | category |
  | Cup  | true          | 2016              | HUM      |
  | Dog  | false         | null              | HUM      |
  | Cat  | false         | null              | HUM      |

  When I follow "Distinguished Professors"
  Then I should see "Distinguished Humanities Professors" before "Cup"
  But I should not see "Dog"
  And I should not see "Cat"

Scenario: There are no distinguished humanities professors (SAD PATH)

  Given the following professors exist:
  | name | distinguished | distinguishedYear | category |
  | Cup  | false         | null              | HUM      |
  | Dog  | false         | null              | HUM      |
  | Cat  | false         | null              | HUM      |

  When I follow "Distinguished Professors"
  Then I should not see "Cup"
  And I should not see "Dog"
  And I should not see "Cat"