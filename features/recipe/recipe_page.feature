@recipe
Feature: Recipe web page
  In order create new records
  And edit records
  And remove records ( we don't really gonna do this one )
    
  Scenario Outline: Create a new recipe by entering the fields
    Given you get to '/recipe/new'
    When you fill in recipe[name] with '<name>'
    And you set the parameter recipe[sections][0][header] to '<header>'
    And you set the parameter recipe[sections][0][text] to '<text>'
    Then you click the button 'Save it!' and create a new Recipe
  
  Examples:
    |name   |header       |text                      |
    |beer   |instructions |buy the kit and follow it |
