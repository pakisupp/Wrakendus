Feature: Testing Intime main functionality

  @User
  Scenario: Making a new user
    When I open Intime
    And log in with "admin"
    And make sure English is selected
    When I open "Create new App User"
    And fill up new user form
    Then user is saved
    When I go to home page
    When I open "List all App Users"
    Then new user is listed
    When I log out
    And log in with "capybara"
    Then main menu items are visible



  #@User
  #Scenario: Updating a new user
    #When I open Intime
    #And log in with "admin"
    #When I open "List all App Users"
    #And I open user form
    #And change user data
    #When I open "List all App Users"
    #Then modified user is listed
    #When I log out
    #And log in with "capybara_modified"
    #Then main menu items are visible

  @Subject
  Scenario: Making a new subject
    When I open Intime
    And log in with "capybara"
    And make sure English is selected
    When I open "Create new Subject"
    And fill up new subject form
    Then subject is saved
    When I go to home page
    When I open "List all Subjects"
    Then new subject is listed

  #@Subject
  #Scenario: Updating a new subject
    #When I open Intime
    #And log in with "capybara"
    #When I open subject form
    #And change subject data
    #When I open "List all Subjects"
    #Then modified subject is listed


  @Usedtime
  Scenario: Adding a new usedtime
    When I open Intime
    And log in with "capybara"
    And make sure English is selected
    When I open "Create new Used Time"
    And fill up new usedtime form
    Then usedtime is saved
    When I go to home page
    When I open "List all Used Times"
    Then new usedtime is listed

  #@Usedtime
  #Scenario: Updating a new usedtime
    #When I open Intime
    #And log in with "capybara"
    #When I open usedtime form
    #And change usedtime data
    #When I open "List all Used Times"
    #Then modified usedtime is listed


  #@Graph
  #Scenario: Testing graph
    #When I open Intime
    #And log in with "admin"
    #When I open "Graph"


  @Delete
  Scenario: Deleting created data
    When I open Intime
    And log in with "capybara"
    And make sure English is selected
    When I open "List all Used Times"
    And delete inserted value
    Then used time is not shown
    When I open "List all Subjects"
    And delete inserted value
    Then subject is not shown
    When I log out
    And log in with "admin"
    When I open "List all App Users"
    And delete the last value
    Then user is not shown
    When I log out
    And log in with "capybara"
    Then login error message is given