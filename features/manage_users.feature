Feature: Manage users
  In order to effectively provide login services
  As a user
  I want to be able to Login, Logout, Register and Edit my profile
  
  Scenario: Register new user
    Given I am on the home page
    When I follow "Register"
    Then I should see "New User"
    When I fill in "Username" with "FernFerret"
    And I fill in "Name" with "Eric Stokes"
    And I fill in "Password" and "Password confirmation" with "password"
    And I fill in "Email" with "email@example.com"
    And I click the "Register" button
    Then I should see "Registration successful."

  Scenario: Logged in as an Admin
    Given I am logged in as an Admin
    And I am on the homepage
    Then I should see "My Databases"
    And I should see "All Databases"

  Scenario: Logged in as a TA
    Given I am logged in as a TA
    And I am on the homepage
    Then I should see "My Databases"
    And I should see "All Databases"

  Scenario: Logged in as a User
    Given I am logged in as a TA
    And I am on the homepage
    Then I should see "My Databases"
    And I should see "Databases Shared with me"
    And I should not see "All Databases"

  Scenario: Not logged in
    Given I am on the homepage
    Then I should not see "All Databases"
    And I should not see "My Databases"

  Scenario: Create a database
    Given I am logged in as a User
    And I am on the homepage
    When I follow "Add Database"
    Then I should see "Add a database"
    When I fill in "Name" with "My new Database"
    And I click the "Add Database" button
    Then I should see "Created new Database successfully"
    And I should see "Database: My new Database"

  Scenario: Create a duplicate database
    Given I am logged in as a User
    And I have created a database named "My Database"
    And I am on the add a database page
    When I fill in "Name" with "My Database"
    Then I should see "Error"
