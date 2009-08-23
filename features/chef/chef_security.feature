@auth
Feature: Chef maintance
  In order to keep chef in check
  As valid chefs
  I want to test that they have encrypted passwords
  And can login
  
  Scenario Outline: Chef will have an encrypted password
    Given a new Chef
    And the chef's password is set to '<password>'
    And the chef's password_confirmation is set to '<password>'
    When the chef calls encrypt_password!
    Then the chef's encrypted_password_store is not decrypted to '<password> foo '
    And the chef's encrypted_password_store is decrypted to '<password>'
  
    Examples:
      |password   |
      |supar cool |
      |$6./ go@!0 |
  
  Scenario Outline: Chef will be authorized by login and password
    Given a new Chef
    And the chef's email is set to '<email>'
    And the chef's login is set to '<login>'
    And the chef's first_name is set to '<first_name>'
    And the chef's last_name is set to '<last_name>'
    And the chef's password is set to '<password>'
    And the chef's password_confirmation is set to '<password>'
    When the chef is saved
    Then the chef is valid
    And the chef's is authorized by '<login>' and '<password>'
    And the chef's is not authorized by '<login>' and '<password> foo'
    And the chef's is not authorized by '<login> foo' and '<password>'
    
    Examples:
      |email               |first_name|last_name|login |password   |
      |fookine@google.com  |bubba     |smith    |cajun |supar cool |
      |omgwoot@farmer.org  |woot      |bar      |budda |black sheep|
      |omgwtf3@yahoo.com   |abhi      |dude     |kidd  |wtf-omg    |
      |cowbuddy@love.net   |woot      |bar      |budda |6 go@0 w00t|
