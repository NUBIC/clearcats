Feature: Viewing all countries
  A user should see all countries

  Scenario: Viewing all countries
    Given an authenticated admin user
    And a country already exists with name: "ASDF"
    When I am on the countries page
    Then I should see "Countries"
    And I should see "ASDF"