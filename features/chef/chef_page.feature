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
    |email        |first_name|last_name|login |password   |
    |foo@bar.com  |bubba     |smith    |cajun |supar cool |
    |omg@w00t.com |woot      |bar      |budda |black sheep|