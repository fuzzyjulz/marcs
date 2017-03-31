Feature: A newsfeed is visible on the main page

Background:

Scenario: Anonymous users can see the newsfeed
 When navigate to the newsfeed
 Then I expect to see the newsfeed
  And I expect to see the newsfeed items

@Member
Scenario: Members can see the newsfeed
 When navigate to the newsfeed
 Then I expect to see the newsfeed
  And I expect to see the newsfeed items

@Committee
Scenario: Committee Members can see the newsfeed
 When navigate to the newsfeed
 Then I expect to see the newsfeed
  And I expect to see the newsfeed items
