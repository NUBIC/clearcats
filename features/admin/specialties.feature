Feature: Viewing all specialties
  A user should see all specialties

  Scenario: Viewing all specialties
    Given an authenticated admin user
    And a specialty already exists with name: "ASDFASDF" and code: "ASDF"
    When I am on the specialties page
    Then I should see "Specialties"
    And I should see "ASDFASDF"
    And I should see "ASDF"