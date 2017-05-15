Feature: As a member I should be able to renew my membership

@Member
Scenario: As a senior member I should be able to renew my membership
 Given I was previously a member
  When I navigate to the membership renewal screen
  Then I expect to be able to renew my membership
   And I expect for an email to be sent confirming the membership renewal
   And I expect for an email to be sent outlining the new membership to the committee
