Feature: I am able to open a preview of a photo

Scenario: Users are able to open previews of photos and navigate through them
 When I navigate to the photo albums screen
  And I click on the photo album
  And I click on the first photo
 Then I expect to see the first photo
  And the "Previous" button is disabled
  
 When I open the next photo
 Then I expect to see the second photo
  And the "Previous" button is not disabled
 
 When I close the photo preview
 Then I expect to not see the second photo
 
 When I open the last photo
 Then I expect to see the last photo
  And the "Next" button is disabled
 
 When I open the previous photo
 Then I expect to see the second last photo
