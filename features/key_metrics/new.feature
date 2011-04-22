Feature: Creating a new key metric
  A user is expected to name the key metric and datatype
  
  Scenario: Creating a brand new key metric
    Given an authenticated user
    When I am on "the key_metrics page"
    And I should see "New Key Metric"
    When I follow "New Key Metric"
    Then I should be on "the new key_metric page"
    And I should see "Name"
    And I should see "Datatype"
    When I fill in "Name" with "My Metric"
    And I select "Amount" from "Datatype"
    And I press "Save"
    And I wait 2 seconds
    Then 1 key_metrics should exist with name: "My Metric"
    And I should be on "the key_metrics page"
    And I should see "My Metric"
    And I should see "Amount"