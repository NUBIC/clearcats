Feature: Editing an existing project
  
  Background:
    Given a project already exists with name: "My New Project"
  
  @javascript
  Scenario: Editing the project
    Given an authenticated admin user
    When I am on the projects page
    Then I should see "My Projects"
    And I should see "My New Project"
    When I follow "Edit"
    Then I should be on the edit project page
    When I fill in "My Edited Project" for "Name"
    And I press "Save"
    Then 1 projects should exist with name: "My Edited Project"
    And I should be on "the projects page"
    And I should see "My Projects"
    And I should see "My Edited Project"