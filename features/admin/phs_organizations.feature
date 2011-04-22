Feature: Viewing all phs organizations
  A user should see all phs organizations

  Scenario: Viewing all phs organizations
    Given an authenticated admin user
    And a phs organization already exists with name: "Peace Corps" and code: "PC"
    When I am on the phs organizations page
    Then I should see "PHS Organizations"
    And I should see "Peace Corps"
    And I should see "PC"