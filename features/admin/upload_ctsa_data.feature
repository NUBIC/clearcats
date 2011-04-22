Feature: CTSA Data file upload
  In order to create ctsa data in the database
  As an admin user
  I want to be able to upload an XSD file with the ctsa schema data

  Scenario: Uploading a valid file
    Given an authenticated admin user
    When I am on the upload ctsa data page
    And I upload a file with valid data
    And I wait 5 seconds
    Then 1 countries should exist with name: "AFGHANISTAN"
