@chef
Feature: Chef CRUD
  Testing simple CRUD on web pages
    
  Scenario Outline: Create a new recipe by entering the fields
    Given you get to '/chef/new'
    When you fill in chef[login] with '<login>'
    And you fill in chef[email] with '<email>'
    And you fill in chef[first_name] with '<first_name>'
    And you fill in chef[last_name] with '<last_name>'
    And you fill in chef[password] with '<password>'
    And you fill in chef[confirm_password] with '<password>'
    Then you click the button 'Save it!' and create a new Chef

  Examples:
    |email          |first_name|last_name|login |password   |
    |eew@google.com |black     |nurse    |cajun |supar cool |
    |vww@yahoo.com  |jack      |slap     |budda |black sheep|
