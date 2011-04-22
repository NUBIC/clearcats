Feature: Viewing all service lines
  In order to manage service lines
  As an admin user
  I want to view all active service lines for an organizational unit

  Scenario: Viewing an empty service lines page
    Given an authenticated admin user
    When I am on the service lines page
    Then I should see "Service Lines"
    And I should see "No service lines were found."
    And I should see "New Service Line"
    
  Scenario: Viewing all service lines
    Given an authenticated admin user
    And an organizational_unit "CECD" with these service_lines:
      | name                   |
      | CRC Basic Training     |
      | How to write a K Award |
    When I am on the service lines page
    Then I should see "Service Lines"
    And I should see "CRC Basic Training"
    And I should see "How to write a K Award"
    And I should see "New Service Line"

  Scenario: Viewing all service lines by organizational unit
    Given an authenticated admin user
    And an organizational_unit "CECD" with these service_lines:
      | name                   |
      | CRC Basic Training     |
      | How to write a K Award |
    And an organizational_unit "ASDF" with these service_lines:
      | name                  |
      | Workshops             |
      | Meeting the President |
    When I am on the service lines page
    Then I should see "Service Lines"
    And I should see "CRC Basic Training"
    And I should see "How to write a K Award"
    And I should see "Workshops"
    And I should see "Meeting the President"
    And I should see "New Service Line"
    When I select "ASDF (ASDF)" from "search_organizational_unit_id_eq"
    And I press "Submit"
    Then I should see "Service Lines for ASDF (ASDF)"
    And I should see "Workshops"
    And I should see "Meeting the President"
    And I should not see "CRC Basic Training"
    And I should not see "How to write a K Award"

