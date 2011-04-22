Feature: Creating a new service line
  In order to manage service lines
  As an admin user
  I want to create a new service lines for an organizational unit

  Scenario: Creating a new service line
    Given an authenticated admin user
    And the following organizational_unit records:
      | name | abbreviation |
      | asdf | asdf         |
    When I am on the service lines page
    Then I should see "Service Lines"
    And I should see "No service lines were found."
    And I should see "New Service Line"
    When I follow "New Service Line" 
    Then I should be on the new service lines page
    And I should see "Create Service Line"
    When I fill in "service_line_name" with "qwer"
    And I press "Save"
    Then I should see "Service Line was successfully created."
    And I should be on the service lines page
    And I should see "qwer"