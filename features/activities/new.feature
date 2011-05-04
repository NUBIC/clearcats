Feature: Adding a new activity for a new project
  A user is expected to name the activity and choose the activity type
  And add people to the activity
  
  Background:
    Given a service_line "Dixon Awards" with these activity_types:
      | name       |
      | Submission |
      | Review     |
      | Award      |
    And a person already exists with name: "Warren Kibbe" and netid: "wakibbe"
    And a role already exists with name: "Roll"
  
  @javascript
  Scenario: Adding a brand new activity for an existing activity type
    Given an authenticated user
    When I am on the home page
    Then I should see "Add Activity/Event"
    When I follow "Add Activity/Event"
    Then I should be on "the new activity page"
    And I should see "Name"
    And I should see "Add People"
    When I fill in "Name" with "asdf"
    And I select "Dixon Awards" from "Service Line"
    And I wait 2 seconds
    Then I should see "Activity Type"
    When I select "Submission" from "Activity Type"
    And I follow "Add Note"
    And I wait 2 seconds 
    Then I should see "Note"
    And I fill in "Note" with "My activity note"
    And I follow "Add Person"
    And I fill in "Person" with "kibb"
    Then I should see "Warren X Kibbe wakibbe"
    When I click on the "Warren X Kibbe wakibbe" autocomplete option
    # Then the "Person" field should contain "Warren X Kibbe wakibbe" 
    And I wait 1 seconds
    Then I select "Roll" from "Role"
    And I press "Save"
    And I wait 1 seconds
    Then 1 activities should exist with name: "asdf"
    And 1 notes should exist with text: "My activity note"
    And I should be on the activities page
    And I should see "asdf"
  