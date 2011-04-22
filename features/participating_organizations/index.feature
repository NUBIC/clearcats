Feature: Viewing all participating organizations
  In order to manage participating organizations
  As an admin user
  I want to view all participating organizations

  Scenario: Viewing an empty participating organizations page
    Given an authenticated admin user
    When I am on the participating organizations page
    Then I should see "Participating Organizations"
    And I should see "No participating organizations were found."
    And I should see "New Participating Organization"
    
  Scenario: Viewing all participating organizations
    Given an authenticated admin user
    And a participating organization already exists with name: "My Participating Org"
    When I am on the participating organizations page
    Then I should see "Participating Organizations"
    And I should see "My Participating Org"
    And I should see "New Participating Organization"
