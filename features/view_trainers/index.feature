Feature: As a member I am able to view the trainer details


@Member
Scenario: As a member I am able to view the trainer details
 When I navigate to the trainer details
 Then I expect to see the plane trainer details
  And I expect to see all plane trainer members
  And I expect to see the heli trainer details
  And I expect to see all heli trainer members

@Committee
Scenario: As a committee member I am able to view the trainer details
 When I navigate to the trainer details
 Then I expect to see the plane trainer details
  And I expect to see all plane trainer members
  And I expect to see the heli trainer details
  And I expect to see all heli trainer members

@NonFinancialMember
Scenario: As a non financial member I am able to view the trainer details
 When I navigate to the trainer details
 Then I expect to not see the plane trainer details
  And I expect to not see the heli trainer details
