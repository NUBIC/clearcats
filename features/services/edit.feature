Feature: Entering information on an existing service
  In order to audit the actions taken for a service
  A user will need to update the client profile
  Or enter activities for that person

  @javascript
  Scenario: Choosing to enter information for an existing service
    Given an authenticated user
    And a person having the name "Warren Kibbe" and the username "wakibbe"
    And an organizational_unit "CECD" with the service_line "CRC Basic Training"
    And a service "CRC Basic Training" for person "wakibbe" having been initiated by the logged in user
    When I am on the edit service page
    Then I should see "Edit Service"
    And I should see "(CECD)"
    And I should see "CRC Basic Training Service for Warren X Kibbe"
    And I should see "Edit Profile for Warren X Kibbe"
    And I should see "Manage Activities"
    