Feature: Manage rows
  In order to manage our database rows
  As a user
  I want to be able to perform the DAVE functions
  

  Scenario: Delete row
    Given the following rows:
      |Key|Data|
      |1|administrator|
      |2|stokesej|
      |3|rhodeska|
    And I am logged in as "administrator"
    And I am on the View Row 1 Page
    When I press "Delete Row"
    Then I should see "Row Successfully Deleted"
    And I should see the following rows:
      |Key|Data|
      |2|stokesej|
      |3|rhodeska|

  Scenario: Add row
    Given I am logged in as "administrator"
    And I am on the new row page
    When I fill in "Data" with "Data1"
    And I press "Create Row"
    Then I should see "New Row Created: Data1"
    And I should see "created by: administrator"

  Scenario: View row
    Given the following tables:
      |Key|Data|
      |My New Row|administrator|
      |New Second Row|stokesej|
      |New Third Row|rhodeska|
    And I am logged in as "administrator"
    And I am on the View Row 1 Page
    Then I should see "My New Row"

  Scenario: Edit row
    Given the following tables:
      |Key|Data|
      |My New Row|data1|
      |New Second Row|data2|
      |New Third Row|data3|
    And I am logged in as "administrator"
    And I am on the Edit Row 1 Page
    When I have filled in "Data" with "New Data 1"
    And I press "Edit Row"
    Then I should see "Row Successfully Edited"
    And I should see the following tables:
      |Key|Data|
      |My New Row|New Data 1|
      |New Second Row|data2|
      |New Third Row|data3|
