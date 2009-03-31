Feature: Chef maintance
  In order to keep chef in check
  As valid chefs
  I want to test that they have encrypted passwords
  And can login
  
  Scenario Outline: Chef will have an encripted password
    Given a new Chef
    When the chef's password is set to '<password>'
    Then the chef's password is not equal to '<password>'
    And the chef's encrypted_password is equal to '<password>'
  
    Examples:
      |email        |first_name|last_name|login |password   |
      |foo@bar.com  |bubba     |smith    |cajun |supar cool |
      |omg@w00t.com |woot      |bar      |budda |black sheep|
      
  Scenario Outline: Chef will be authorized by login and password
    Given a new Chef
    And the chef's email is set to '<email>'
    And the chef's login is set to '<login>'
    And the chef's first_name is set to '<first_name>'
    And the chef's last_name is set to '<last_name>'
    And the chef's password is set to '<password>'
    When the chef is saved
    Then the chef's is authorized by '<login>' and '<password>'
    And the chef's is not authorized by '<login>' and '<password> foo'
    And the chef's is not authorized by '<login> foo' and '<password>'
    
    Examples:
      |email        |first_name|last_name|login |password   |
      |foo@bar.com  |bubba     |smith    |cajun |supar cool |
      |omg@w00t.com |woot      |bar      |budda |black sheep|
    