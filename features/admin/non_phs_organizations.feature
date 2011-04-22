Feature: Viewing all non-phs organizations
  A user should see all non-phs organizations

  Scenario: Viewing all non-phs organizations
    Given an authenticated admin user
    And a non-phs organization already exists with name: "Peace Corps" and code: "PC"
    When I am on the non-phs organizations page
    Then I should see "Non PHS Organizations"
    And I should see "Peace Corps"
    And I should see "PC"