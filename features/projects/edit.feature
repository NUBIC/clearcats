Feature: Editing an existing project
  
  Background:
    Given a project already exists with name: "My New Project"
    And a key metric already exists with name: "My Key Metric"
  
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
    
  @javascript
  Scenario: Editing the project with nested attributes
    Given an authenticated admin user
    When I am on the projects page
    Then I should see "My Projects"
    And I should see "My New Project"
    When I follow "Edit"
    Then I should be on the edit project page
    When I follow "Add Note"
    Then I should see "Remove"
    When I fill in "This is a note for My Edited Project" for "Note"
    And I follow "Add Key Metric"
    And I select "My Key Metric" from "Key Metric"
    And I fill in "My Edited Project" for "Name"
    And I press "Save"
    Then 1 projects should exist with name: "My Edited Project"
    And I should be on "the projects page"
    And I should see "My Projects"
    And I should see "My Edited Project"