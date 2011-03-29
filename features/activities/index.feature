Feature: Viewing all activities
  A user should see all activities
  
  Scenario: Viewing all activities without a activity
    Given an authenticated user
    When I am on the activities page
    Then I should see "My Activities"
    And I should see "No activities were found."
    And I should see "New Activity"

  @javascript
  Scenario: Viewing all activities
    Given an authenticated admin user
    And an activity already exists with name: "My Fine Activity"
    When I am on the activities page
    Then I should see "My Activities"
    And I should see "My Fine Activity"