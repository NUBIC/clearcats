Feature: Searching Approvals
  In order to find an approval record in the database
  As an admin user
  I want to be able to search the approvals by entering criteria
  
  Scenario: Finding an existing approval record
    Given an authenticated user
    And the following approval records:
      | tracking_number | project_title  |
      | STU111          | Phase I Thing  |
      | STU222          | Phase II Study |
      | STU333          | Some Drug      |
    When I am on the approvals search page
    Then I should see "STU111"
    And I should see "STU222"
    And I should see "STU333"
    When I fill in "search_project_title_like" with "II"
    And I press "Search"
    Then I should see "STU222"
    And I should see "Phase II Study"
    And I should not see "STU111"
    And I should not see "STU333"