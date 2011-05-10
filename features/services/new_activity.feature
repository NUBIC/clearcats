Feature: Adding an activity to an existing service
  In order to manage an existing service
  A user is expected to add activities to that service
  
  @javascript
  Scenario: Managing an existing service
    Given an authenticated user
    And a person having the name "AS DF" and the username "asdfasdf"
    And an organizational_unit "CECD" with the service_line "Basic Training"
    And a service "Basic Training" for person "asdfasdf" having been initiated by the logged in user
    And I am on the service activities page
    Then I should see "Activities for CECD Basic Training - AS X DF"
    And I should see "No activities were found."
    When I follow "New Activity"
    Then I should see "New Activity for AS X DF"
    And I should see "Service Line"
    And I should see "Basic Training"
    And the "Date" field should be set to today
    When I follow "Add Note"
    Then I should see "Note" 
    And I should see "Remove"
    When I fill in "Note" with "This is a note"
    And I fill in "Name" with "A Strange Name"
    And I press "Save"
    And I wait 2 seconds
    Then 1 activities should exist with name: "A Strange Name"
    # And I wait 2 seconds
    # Then I should see "A Strange Name"
    # And I should see "Show Notes..."
    