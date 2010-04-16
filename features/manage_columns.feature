Feature: Manage columns
  In order to manage our database columns
  As a user
  I want to be able to perform the DAVE functions on columns in a database I can control
  

  Scenario: Delete column
    Given the following columns:
      |Name|Type|Null|
      |Color|string|null|
      |Name|string|notnull|
      |Added|date|notnull|
    And I am logged in as "administrator"
    And I am on the View Table 1 Page
    When I press "Delete Color Column"
    Then I should see "Column Successfully Deleted"
    And I should see the following columns:
      |Name|Type|Null|
      |Name|string|notnull|
      |Added|date|notnull|

  Scenario: Add column
    Given I am logged in as "administrator"
    And I am on the new column page
    When I fill in "Name" with "Brand"
    And I fill in "Type" with "string"
    And I fill in "Null" with "null"
    And I press "Create Column"
    Then I should see "New Column Created: Brand"
    And I should see "created by: administrator"

  # Removed View Column, as it won't ever happen alone

  Scenario: Edit column
    Given the following tables:
      |Name|Type|Null|
      |Color|string|null|
      |Name|string|notnull|
      |Added|date|notnull|
    And I am logged in as "administrator"
    And I am on the View Table 1 Page
    When I press "Edit Color Column"
    Then I should see "Editing the Color Column"    
    When I have filled in "Name" with "Smell"
    And I press "Save Column"
    Then I should see "Column Successfully Edited"
    And I should see the following tables:
      |Name|Type|Null|
      |Smell|string|null|
      |Name|string|notnull|
      |Added|date|notnull|
