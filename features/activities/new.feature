Feature: Adding a new activity for a new project
  A user is expected to name the activity and choose the activity type
  And add people to the activity
  
  Background:
    Given an activity type already exists with name: "Introduction to Collaboration"
    And a person already exists with name: "Warren Kibbe" and netid: "wakibbe"
    And a role already exists with name: "Roll"
  
  @javascript
  Scenario: Adding a brand new activity for an existing activity type
    Given an authenticated user
    When I am on the home page
    Then I should see "Add Activity/Event"
    When I follow "Add Activity/Event"
    Then I should be on "the new activity page"
    And I should see "Activity Type"
    And I should see "Name"
    And I should see "Add People"
    When I fill in "Name" with "asdf"
    And I fill in "Activity Type" with "Intr"
    Then I should see "Introduction to Collaboration"
    When I click on the "Introduction to Collaboration" autocomplete option
    Then the "activity_activity_type_name" field should contain "Introduction to Collaboration"
    When I press "Save"
    And I wait 2 seconds
    Then 1 activities should exist with name: "asdf"
    And I should be on the activities page
    And I should see "asdf"
    
  @javascript
  Scenario: Adding a brand new activity with nested attributes
    Given an authenticated user
    And I am on on "the new activity page"
    When I fill in "Name" with "My Activity"
    And I follow "Add Note"
    And I wait 2 seconds 
    Then I should see "Note"
    And I fill in "Note" with "My activity note"
    And I follow "Add Person"
    And I fill in "Person" with "kibb"
    # And I fill in "[@class='person_select_autocompleter']" with "kibbe"
    Then I should see "Warren X Kibbe wakibbe"
    When I click on the "Warren X Kibbe wakibbe" autocomplete option
    Then the "Person" field should contain "Warren X Kibbe wakibbe" 
    When I select "Roll" from "Role"
    # Then I should see "Warren X Kibbe wakibbe" within "[@class='person_select_autocompleter']"
    When I press "Save"
    Then 1 activities should exist with name: "My Activity"
    And 1 notes should exist with text: "My activity note"
  