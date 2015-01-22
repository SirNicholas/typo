Feature: Categories
  As an admin
  In order to manage categories of articles
  I want to create/edit categories

  Background:
    Given the blog is set up
    And I am logged into the admin panel
    And I am on the new category page

  Scenario: add new category
    When I fill in "category_name" with "Testing category"
    And I fill in "category_keywords" with "feature"
    And I fill in "category_permalink" with ""
    And I fill in "category_description" with "My cool category for testing"
    And I press "Save"
    Then I should see "Category was successfully saved."
    And I should see "Testing category"

  Scenario: edit existed category
    When I follow "Edit"
    Then I should be on the edit category page
    When I fill in "category_name" with "Testing category"
    And I fill in "category_keywords" with "feature"
    And I fill in "category_permalink" with ""
    And I fill in "category_description" with "My cool category for testing"
    And I press "Save"
    Then I should be on the new category page
    And I should see "Category was successfully saved."
    And I should see "Testing category"