Feature: Viewing all key metrics
  A user should see all key metrics
  
  Scenario: Viewing all key metrics without any existing
    Given an authenticated user
    When I am on the key_metrics page
    Then I should see "Key Metrics"
    And I should see "No metrics were found."
    And I should see "New Key Metric"

  Scenario: Viewing all key metrics
    Given an authenticated admin user
    And a key metric already exists with name: "My Key Metric"
    When I am on the key_metrics page
    Then I should see "Key Metrics"
    And I should see "My Key Metric"