Feature: Editing a participating organizations
  In order to manage participating organizations
  As an admin user
  I want to edit an existing participating organization

  Scenario: Editing a selected participating organization
    Given an authenticated admin user
    And a participating organization already exists with name: "My Participating Org"
    When I am on the participating organizations page
    Then I should see "Participating Organizations"
    And I should see "My Participating Org"
    And I should see "New Participating Organization"
    When I follow "Edit"
    Then I should be on the participating organizations edit page
    And I should see "Edit Participating Organization"
    When I fill in "participating_organization_name" with "My Participating Organization"
    And I press "Submit"
    Then I should be on the participating organizations page
    And I should see "Participating Organization was successfully updated."
    And I should see "My Participating Organization"
    