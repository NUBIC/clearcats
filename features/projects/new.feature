Feature: Creating a new project
  A user is expected to name the project and choose the service line
  
  Background:
    Given a service line already exists with name: "My Service Line"
  
  Scenario: Starting a brand new project
    Given an authenticated user
    When I am on the home page
    Then I should see "My Projects"
    When I follow "My Projects"
    Then I should be on "the projects page"
    And I should see "New Project"
    When I follow "New Project"
    Then I should be on "the new project page"
    And I should see "Name"
    And I should see "Service Line (optional)"
    When I fill in "Name" with "My New Project"
    When I press "Save"
    And I wait 2 seconds
    Then 1 projects should exist with name: "My New Project"
    And I should be on "the projects page"
    And I should see "My Projects"
    And I should see "My New Project"