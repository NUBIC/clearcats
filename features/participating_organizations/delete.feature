Feature: Deleting participating organizations
  In order to manage participating organizations
  As an admin user
  I want to delete an unused participating organization

  Scenario: Deleting a selected participating organizations
    Given an authenticated admin user
    And a participating organization already exists with name: "My Participating Org"
    When I am on the participating organizations page
    Then I should see "Participating Organizations"
    And I should see "My Participating Org"
    And I should see "New Participating Organization"
    When I follow "Delete"
    Then I should be on the participating organizations page
    And I should see "Participating Organizations"
    And I should see "No participating organizations were found."
    And I should see "New Participating Organization"
