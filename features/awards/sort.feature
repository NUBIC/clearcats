Feature: Sorting Awards
  In order to find an award record in the database quickly
  As an admin user
  I want to be able to sort the award records
  
  @javascript
  Scenario: Sorting existing award records
    Given an authenticated user
    And the following award records:
      | grant_number | grant_title | budget_identifier        |
      | 000000       | whoops      | NORTHWESTU00000000000000 |
      | 111111       | lucky       | NORTHWESTU00000011111111 |
      | 333333       | and some    | NORTHWESTU00000033333333 |
      | 999999       | whatev      | NORTHWESTU00000099999999 |
    When I am on the awards search page
    Then I should see "Awards Search"
    And I should see "whoops"
    When I follow "Grant Title"
    Then I should be on the awards search page
    And "and some" should appear before "whatev"
    When I follow "Grant Title"
    Then I should be on the awards search page
    And "whatev" should appear before "and some"