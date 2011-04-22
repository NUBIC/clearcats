Feature: Searching People
  In order to find a person record in the database
  As an admin user
  I want to be able to search the people by entering criteria
  
  Scenario: Finding an existing person record
    Given an authenticated user
    And the following client records:
      | first_name | last_name | netid |
      | Warren     | Harding   | wgh   |
      | Benjamin   | Franklin  | bf100 |
      | Adolf      | Hitler    | ss    |
    When I am on the person search page
    Then I should see "Franklin"
    When I fill in "search_last_name_like" with "Hit"
    And I press "Search"
    Then I should see "Adolf"
    And I should see "Hitler"
    And I should not see "Franklin"
