Feature: Logging into the application
  A user is expected to see a different landing page based on their access rights
    
  Scenario: Logging in as an admin user
    Given an authenticated admin user
    When I am on the home page
    Then I should see "Add Investigator"
    And I should see "Manage Service Lines"
    And I should see "Manage Investigators"
  
  Scenario: Logging in as a user
    Given an authenticated user
    When I am on the home page
    Then I should see "Add Investigator"
    And I should see "Add Activity/Event"
    And I should see "My Projects"
  