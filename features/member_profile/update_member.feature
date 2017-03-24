Feature: As a member I am able to update my own details


@Member
Scenario: As a member I am able to update my own details
 When I navigate to the member profile screen
 Then I expect to see my profile details 
  And I expect to see that I am financial 
 When I update my profile details
 Then I expect to see my updated profile details 

@Committee
Scenario: As a committee member I am able to update my own details
 When I navigate to the member profile screen
 Then I expect to see my profile details 
  And I expect to see that I am financial 
 When I update my profile details
 Then I expect to see my updated profile details 

@NonFinancialMember
Scenario: As a non financial member I am able to update my own details and see my financial status
 When I navigate to the member profile screen
 Then I expect to see my profile details 
  And I expect to see that I am not financial 
 When I update my profile details
 Then I expect to see my updated profile details
