Feature: Viewing all activity types
  A user should see all activity types
  
  Scenario: Viewing an empty activity types page
    Given an authenticated user
    When I am on the activity types page
    Then I should see "Activity Types"
    And I should see "No activity types were found."
    And I should see "New Activity"
    
  Scenario: Viewing all activity types
    Given an authenticated user
    And a service_line "Service Line" with these activity_types:
    | name         |
    | Activity One |
    | Activity Two |
    When I am on the activity types page
    Then I should see "Activity Types"
    And I should see "Service Line"
    And I should see "Activity One"
    And I should see "Activity Two"
    And I should see "New Activity Type"
