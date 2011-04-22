Feature: Editing a service lines
  In order to manage service lines
  As an admin user
  I want to edit a service lines for an organizational unit
    
  Scenario: Editing a selected service line
    Given an authenticated admin user
    And an organizational_unit "CECD" with these service_lines:
      | name                   |
      | How to write a K Award |
    When I am on the service lines page
    Then I should see "Service Lines"
    And I should see "How to write a K Award"
    And I should see "New Service Line"
    When I follow "Edit"
    Then I should be on the service lines edit page
    And I should see "Edit Service Line"
    When I fill in "service_line_name" with "How NOT to write a K Award"
    And I press "Save"
    Then I should be on the service lines page
    And I should see "Service Line was successfully updated."
    And I should see "How NOT to write a K Award"
    
