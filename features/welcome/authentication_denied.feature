Feature: Authenticating People
  In order to restrict access to data in the application
  As a client user
  I should not be allowed to view certain data
    
  Scenario: Logging in as a client user
    Given an authenticated client user
    When I go to the specialties page
    Then I should see "Authentication Denied"
    And I should see "have requested a resource to which you do not have access"
