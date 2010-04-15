Feature: Manage tables
  In order to manage our database tables
  As a user
  I want to be able to perform the DAVE functions
  

  Scenario: Delete table
    Given the following tables:
      |Name|Owner|
      |My New Table|administrator|
      |New Second Table|stokesej|
      |New Third Table|rhodeska|
    And I am logged in as "administrator"
    And I am on the View Table 1 Page
    When I press "Delete Table"
    Then I should see "Table Successfully Deleted"
    And I should see the following tables:
      |Name|Owner|
      |New Second Table|stokesej|
      |New Third Table|rhodeska|

  Scenario: Add table
    Given I am logged in as "administrator"
    And I am on the new table page
    When I fill in "Name" with "My New Table"
    And I press "Create Table"
    Then I should see "New Table Created: My New Table"
    And I should see "created by: administrator"

  Scenario: View table
    Given the following tables:
      |Name|Owner|
      |My New Table|administrator|
      |New Second Table|stokesej|
      |New Third Table|rhodeska|
    And I am logged in as "administrator"
    And I am on the View Table 1 Page
    Then I should see "My New Table"

  Scenario: Edit table
    Given the following tables:
      |Name|Owner|
      |My New Table|administrator|
      |New Second Table|stokesej|
      |New Third Table|rhodeska|
    And I am logged in as "administrator"
    And I am on the Edit Table 1 Page
    When I have filled in "Name" with "My Super New Table 2"
    And I press "Edit Table"
    Then I should see "Table Successfully Edited"
    And I should see the following tables:
      |Name|Owner|
      |My Super New Table 2|administrator|
      |New Second Table|stokesej|
      |New Third Table|rhodeska|
