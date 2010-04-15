Feature: Manage databases
  In order to manage our databases
  As a user
  I want to be able to perform the DAVE functions
  

  Scenario: Delete database
    Given the following databases:
      |Name|Owner|
      |My New Database|administrator|
      |New Second Database|stokesej|
      |New Third Database|rhodeska|
    And I am logged in as "administrator"
    And I am on the View Database 1 Page
    When I press "Delete Database"
    Then I should see "Database Successfully Dropped"
    And I should see the following tables:
      |Name|Owner|
      |New Second Database|stokesej|
      |New Third Database|rhodeska|

  Scenario: Add database
    Given I am logged in as "administrator"
    And I am on the new database page
    When I fill in "Name" with "My New Database"
    And I press "Create Database"
    Then I should see "New Database Created: My New Database"
    And I should see "created by: administrator"

  Scenario: View Database
    Given the following databases:
      |Name|Owner|
      |My New Database|administrator|
      |New Second Database|stokesej|
      |New Third Database|rhodeska|
    And I am logged in as "administrator"
    And I am on the View Database 1 Page
    Then I should see "My New Database"

  Scenario: Edit database
    Given the following databases:
      |Name|Owner|
      |My New Database|administrator|
      |New Second Database|stokesej|
      |New Third Database|rhodeska|
    And I am logged in as "administrator"
    And I am on the Edit Database 1 Page
    When I have filled in "Name" with "My Super New Database 2"
    And I press "Edit Database"
    Then I should see "Database Successfully Edited"
    And I should see the following tables:
      |Name|Owner|
      |My Super New Database 2|administrator|
      |New Second Database|stokesej|
      |New Third Database|rhodeska|
