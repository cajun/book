Feature: Chef maintance
  In order to keep chefi in check
  As valid chefs
  I want to test that they have encrypted passwords
  
  Scenario Outline: Chef will encrypt the password
    Given a new Chef
    And the chef's email is set to '<email>'
    And the chef's name is set to '<login>'
    And the chef's login is set to '<login>'
    When the chef's password is set to '<password>'
    Then the chef's password is set to '<password>'
    
    Examples:
      |email        |login|password   |
      |foo@bar.com  |cajun|supar cool |
      |omg@w00t.com |budda|black sheep|
    