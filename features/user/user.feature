Feature: User maintance
  In order to keep users in check
  As valid users
  I want to test that they have encrypted passwords
  
  Scenario Outline: User will encrypt the password
    Given a new User
    And the user's email is set to '<email>'
    And the user's login is set to '<login>'
    When the user's password is set to '<password>'
    Then the password will be encrypted and have a length of 60
    
    Examples:
      |email        |login|password   |
      |foo@bar.com  |cajun|supar cool |
      |omg@w00t.com |budda|black sheep|
    