Feature: Chef CRUD
  Testing simple CRUD on web pages
  
  Scenario Outline: Create a Chef with valid parameters
    Given you get to '/chef/new'
    When you set the parameter email to '<email>'
    And you set the parameter login to '<login>'
    And you set the parameter first_name to '<first_name>'
    And you set the parameter last_name to '<last_name>'
    And you set the parameter password to '<password>'
    Then you post to '/chef/create' and create a new Chef
  
  Examples:
    |email            |first_name|last_name|login |password   |
    |ges7.ds@bar.com  |kreal     |p b      |cajun |supar cool |
    |or1.foo@w00t.com |woot      |bar      |budda |black sheep|
    
  Scenario Outline: Create a new recipe by entering the fields
    Given you get to '/chef/new'
    When you fill in chef[login] with '<login>'
    And you fill in chef[email] with '<email>'
    And you fill in chef[first_name] with '<first_name>'
    And you fill in chef[last_name] with '<last_name>'
    And you fill in chef[password] with '<password>'
    Then you click the button 'Save it!' and create a new Chef

  Examples:
    |email        |first_name|last_name|login |password   |
    |eew@bar.com  |black     |nurse    |cajun |supar cool |
    |vww@w00t.com |jack      |slap     |budda |black sheep|
