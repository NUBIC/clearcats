Feature: Deleting service lines
  In order to manage service lines
  As an admin user
  I want to delete an unused service lines for an organizational unit

  Scenario: Select a service line to delete
    Given an authenticated admin user
    And an organizational_unit "CECD" with these service_lines:
      | name                   |
      | Delete me              |
    When I am on the service lines page
    Then I should see "Service Lines"
    And I should see "Delete me"
    And I should see "New Service Line"
    When I follow "Delete"
    Then I should be on the service lines page
    And I should see "Service Lines"
    And I should see "No service lines were found."
    And I should see "New Service Line"
