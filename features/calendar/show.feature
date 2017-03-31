Feature: The Calendar is visible to users

Scenario: The calendar is visible and shows events
 When I navigate to the calendar
 Then I expect to see the calendar
  And I expect to see the club events
  And I expect to not see the committee events

@Member
Scenario: The calendar is visible and shows events
 When I navigate to the calendar
 Then I expect to see the calendar
  And I expect to see the club events
  And I expect to not see the committee events

@Committee
Scenario: The calendar is visible and shows events
 When I navigate to the calendar
 Then I expect to see the calendar
  And I expect to see the club events
  And I expect to see the committee events
