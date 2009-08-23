@recipe
Feature: Recipe maintance
  In order to keep recipes in check
  As valid recipes
  I want to test that the validations work
  
  Background:
    Given a new Recipe
    And the recipe's name is set to 'hamburger'
    And the recipe's instructions is set to 'always cook on a big green egg'
    And a new Chef
    And the chef's login is set to 'cajun'
    And the recipe's chef is set to @chef
    
  Scenario: A Recipe will have a name
    Given a valid recipe
    When the recipe's name is set to nil
    Then recipe will not be valid
  
  @results_ranking
  Scenario: A Recipe will have different many results
    Given a valid recipe
    And a new Result
    And the result's rank is set to '10'
    And the result's body is set to 'sweet james this was good'
    When the result is added to the recipe's results 2 times
    Then the recipe's results will have 2 more
    And save the recipe
