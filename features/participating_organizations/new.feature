Feature: Creating a new participating organization
  In order to manage participating organizations
  As an admin user
  I want to create a new participating organization

  Scenario: Creating a new participating organization
    Given an authenticated admin user
    And a country already exists with name: "UNITED STATES"
    When I am on the participating organizations page
    Then I should see "Participating Organizations"
    And I should see "No participating organizations were found."
    And I should see "New Participating Organization"
    When I follow "New Participating Organization"
    Then I should be on the new participating organizations page
    And I should see "New Participating Organization"
    When I fill in "participating_organization_name" with "PO Name"
    And I fill in "participating_organization_city" with "PO City"
    And I press "Submit"
    Then I should see "Participating Organization was successfully created. "
    And I should be on the participating organizations page
    And I should see "PO Name"
    And I should see "PO City"