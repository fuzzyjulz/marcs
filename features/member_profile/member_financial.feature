Feature: As a member I am able to see the correct financial status

@Member
Scenario: As a member I am able to see the financial state at the start of the year
 When I navigate to the member profile screen
 Then I expect to see my profile details 
  And I expect to see that I am financial 

@Member
Scenario: As a member I am able to see the financial state at the end of the year
 When it is at the end of the full year membership period
  And I navigate to the member profile screen
 Then I expect to see my profile details 
  And I expect to see that I am financial 

@Member
Scenario: As a member I am able to see the non financial state at the start of the next year
 When it is at the start of the next membership period
  And I navigate to the member profile screen
 Then I expect to see my profile details 
  And I expect to see that I am not financial 
