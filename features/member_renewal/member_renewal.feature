Feature: As a member I should be able to renew my membership

@Member
Scenario: As a senior member I should be able to renew my full year membership
 Given I was previously a member
   And it is within the full year membership period
   
  When I navigate to the membership renewal screen
  
  Then I expect to be shown the full financial year
   And I expect to see my address
   And I expect that my membership type is selected
   
  When I agree to the rules and continue
  Then I expect to not see the half year membership notice
   And I expect to see the Senior full member fee
  
  When I enter a transaction number and click next
  Then I expect to see the membership renewal complete screen


@Member
Scenario: As a senior member I should be able to renew my half year membership
 Given I was previously a member
   And it is within the half year membership period
   
  When I navigate to the membership renewal screen
  
  Then I expect to be shown the half financial year
   And I expect to see my address
   And I expect that my membership type is selected
   
  When I agree to the rules and continue
  Then I expect to see the half year membership notice
   And I expect to see the Senior full member half year fee
  
  When I enter a transaction number and click next
  Then I expect to see the membership renewal complete screen


@Member
Scenario: As a senior member if my membership has already been sent I should not be able to resend it
 Given I was previously a member
   And it is within the full year membership period
   
  When I navigate to the membership renewal screen
   And I agree to the rules and continue
   And I enter a transaction number and click next
   
  Then I expect to see the membership renewal complete screen
   And I expect to see the link back to the fees
  
  When the day is day after tomorrow
   And I navigate to the membership renewal screen
   
  Then I expect to see the membership renewal complete screen
   And I expect to not see the link back to the fees
