Feature: Creating a new service
  In order to create a new service
  A user is expected to login
  And enter the required data for that service    

  @javascript
  Scenario: Creating a new service and choosing both the person and service line up to being identified
    Given an authenticated user
    And a person having these attributes:
      | name         | netid   | employeeid |
      | Warren Kibbe | wakibbe | 1018461    | 
    And an organizational_unit "CECD" with the service_line "CRC Basic Training"
    When I go to the new service page
    And I follow "Choose Investigator"
    Then I should be on the services choose person page
    When I fill in "Net ID" with "wakibbe"
    And I press "Search"
    When I choose "service[person_id]"
    And I press "Continue"
    Then I should be on the new service page
    When I follow "Choose"
    Then I should be on the service choose service line page
    When I choose "CRC Basic Training"
    And I press "Continue"
    Then I should be on the services page
