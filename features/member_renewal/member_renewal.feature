Feature: As a member I should be able to renew my membership

@Member
Scenario: As a senior member I should be able to renew my full year membership
 Given I was previously a member
   And it is within the full year membership period
   
  When I navigate to the membership renewal screen
  
  Then I expect to see the full year membership fees
   And I expect to be able to renew my membership
   And I expect for an email to be sent confirming the membership renewal
   And I expect for an email to be sent outlining the new membership to the committee


@Member
Scenario: As a senior member I should be able to renew my half year membership
 Given I was previously a member
   And it is within the half year membership period
   
  When I navigate to the membership renewal screen
  
  Then I expect to see the half year membership fees
   And I expect to be able to renew my membership
   And I expect for an email to be sent confirming the membership renewal
   And I expect for an email to be sent outlining the new membership to the committee


@Member
Scenario: As a senior member if my membership has already been sent I should not be able to resend it
 Given I was previously a member
   And it is within the full year membership period
   
  When I navigate to the membership renewal screen
  Then I expect to see the full year membership fees
   And I expect to be able to renew my membership
   And I expect for an email to be sent confirming the membership renewal
   And I expect for an email to be sent outlining the new membership to the committee
   
  When I navigate to the membership renewal screen
   And I expect to not be able to renew my membership
