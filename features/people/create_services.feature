Feature: Creating Services for a Person
  In order to easily associate a person with several services
  As a user
  I want to be able to choose several service lines at one time to create those services
  
  Scenario: Creating several services for a chosen person
    Given an authenticated user
    And the following client records:
      | first_name | middle_name | last_name | netid |
      | Benjamin   | X           | Franklin  | bf100 |
    And an organizational_unit "CECD" with these service_lines:
      | name |
      | aaa  |
      | xxx  |
      | zzz  |
    When I am on the person new services page
    Then I should see "Create Services"
    And I should see "Choose Service Lines for Benjamin X Franklin"
    When I check "aaa"
    And I check "zzz"
    And I press "Save"
    Then I should be on the person services page
    And I should see "aaa"
    And I should see "zzz"
    And I should not see "xxx"
