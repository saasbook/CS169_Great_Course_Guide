Feature: Distinguished Teachers

  As a student
  So that I can see finish my non-major requirements
  I would like to see a list of classes that I could take to fill my non-major requirements

Scenario: Seeing Possible Non-Major Classes
  Given the following courses exist:
  | title                   | number          |
  | ABCD                    | CS61A           |
  | EFGH                    | CS61B           |
  | IJKL                    | CS61C           |
  | MNOP                    | CHEM1           |
  Given I am on the welcome page
  And I login as "Michael"
  When I follow "Non-major Requirements"
  Then I should see "CHEM1"
