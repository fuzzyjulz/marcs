Feature: Users are able to view a photo album

Scenario: All users are able to see a photo album
 When I navigate to the photo albums page
  And I click on the photo album
 Then I expect to see a list of all photos in the album order of the album name
