Feature: Editing an existing metric
  
  Background:
    Given a key metric already exists with name: "My New Metric"
  
  Scenario: Editing the key metric
    Given an authenticated admin user
    When I am on the key metrics page
    Then I should see "Key Metrics"
    And I should see "My New Metric"
    When I follow "Edit"
    Then I should be on the edit key metric page
    When I fill in "My Edited Metric" for "Name"
    And I press "Save"
    Then 1 key_metrics should exist with name: "My Edited Metric"
    And I should be on "the key metrics page"
    And I should see "Key Metrics"
    And I should see "My Edited Metric"