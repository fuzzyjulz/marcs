Feature: As a member I am able to view the committee details


@Member
Scenario: As a member I am able to view the committee details
 When I navigate to the committee details
 Then I expect to see the committee details
  And I expect to see all committee members

@Committee
Scenario: As a committee member I am able to view the committee details
 When I navigate to the committee details
 Then I expect to see the committee details
  And I expect to see all committee members


@NonFinancialMember
Scenario: As a non financial member I am able to view the committee details
 When I navigate to the committee details
 Then I expect to see the committee details
  And I expect to see all committee members
