Feature: Manage projects


  Scenario: Register new project
    Given I am on the new project page
    When I fill in "Name" with "name 1"
    And I fill in "Path" with "path 1"
    And I press "Create"
    Then I should see "name 1"
