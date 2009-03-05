Feature: Recipe maintance
  In order to keep recipes in check
  As valid recipes
  I want to test that the validations work
  
  Background:
    Given a new Recipe
    And the recipe's name is set to 'hamburger'
    And the recipe's instructions is set to 'always cook on a big green egg'
    And the recipe's author is set to 'cajun'
    
  Scenario: A Recipe will have a name
    Given a valid recipe
    When the recipe's name is set to nil
    Then recipe will not be valid
    
  Scenario: A Recipe will have instructions
    Given a valid recipe
    When the recipe's instructions is set to nil
    Then recipe will not be valid
  