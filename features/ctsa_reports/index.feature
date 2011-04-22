Feature: Viewing all ctsa reports
  In order to manage ctsa reports
  As an admin user
  I want to view all active ctsa reports

  Scenario: Viewing the ctsa reports page
    Given an authenticated admin user
    When I am on the ctsa reports page
    Then I should see "CTSA Report Summary for 2011"
    And I should see "No CTSA reports were found."
    And I should see "New CTSA Report"