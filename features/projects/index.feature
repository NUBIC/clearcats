Feature: Viewing all projects
  A user should see all projects
  
  Scenario: Viewing all projects without a project
    Given an authenticated user
    When I am on the projects page
    Then I should see "My Projects"
    And I should see "No projects were found."
    And I should see "New Project"

  Scenario: Viewing all projects
    Given an authenticated admin user
    And a project already exists with name: "My Fine Project"
    When I am on the projects page
    Then I should see "My Projects"
    And I should see "My Fine Project"
