@auth
Feature: Chef maintance
  In order to keep chef in check
  As valid chefs
  I want to test that they have encrypted passwords
  And can login
  
  Scenario Outline: Chef will have an encrypted password
    Given a new Chef
    And the chef's password is set to '<password>'
    When the chef calls encrypt_password!
    Then the chef's encrypted_password is not decrypted to '<password> foo '
    And the chef's encrypted_password is decrypted to '<password>'
  
    Examples:
      |email        |first_name|last_name|login |password   |
      |foo@bar.com  |bubba     |smith    |cajun |supar cool |
      |cow@w00t.com |woot      |bar      |budda |$6./ go@!0 |
  
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
      |omg@t--t.com |abhi      |dude     |kidd  |wtf        |
      |cow@w00t.com |woot      |bar      |budda |6 go@0     |
