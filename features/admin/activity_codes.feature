Feature: Viewing all activity codes
  A user should see all activity codes

  Scenario: Viewing all activity codes
    Given an authenticated admin user
    And an activity code already exists with name: "My Activity Code" and code: "MAC"
    When I am on the activity codes page
    Then I should see "Activity Codes"
    And I should see "My Activity Code"
    And I should see "MAC"