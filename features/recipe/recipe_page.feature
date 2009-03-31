Feature: Recipe web page
  In order create new records
  And edit records
  And remove records ( we don't really gonna do this one )
  
  Scenario Outline: Create a new recipe
    Given you get to '/recipe/new'
    When you set the parameter name to '<name>'
    And you set the parameter instructions to '<instructions>'
    Then you post to '/recipe/create' and create a new Recipe

  Examples:
    |name   |instructions                |
    |beer   |buy the kit and follow it   |
      
  Scenario Outline: Create a new recipe by entering the fields
    Given you get to '/recipe/new'
    When you fill in recipe[name] with '<name>'
    And you fill in recipe[instructions] with '<instructions>'
    Then you click the button 'Save it!' and create a new Recipe
  
  Examples:
    |name   |instructions                |
    |beer   |buy the kit and follow it   |
  