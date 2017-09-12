Feature: As a member I should be able to renew my membership

@NonFinancialMember
Scenario: As a non financial member I am able to renew my membership
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
Scenario: As a senior member I should be able to renew my full year membership
 Given I was previously a member
   And it is within the full year membership period
   
  When I navigate to the membership renewal screen
  Then I expect to see the membership renewal complete screen


@NonFinancialMember
Scenario: As a non financial member I should be able to renew my half year membership
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
Scenario: As a senior member, if I have already renewed for this year, I shouldn't be able to enrol for the half year
 Given I was previously a member
   And it is within the half year membership period
   
  When I navigate to the membership renewal screen
  Then I expect to see the membership renewal complete screen


@AffiliateMember
Scenario: As an senior affiliate member I should be able to renew my membership
 Given I was previously a member
   And it is within the full year membership period
   
  When I navigate to the membership renewal screen
  
  Then I expect that my membership type is selected
   And I expect that I am shown as an affiliate member
   And I expect to see my affiliated club name
   
  When I agree to the rules and continue
   And I expect to see the Senior Affiliate member full year fee
  
  When I enter a transaction number and click next
  Then I expect to see the membership renewal complete screen


@LifeMember
Scenario: As a senior Life member I should be able to renew my membership
 Given I was previously a member
   And it is within the full year membership period
   
  When I navigate to the membership renewal screen
  
  Then I expect that my membership type is selected
   And I expect that I am shown as a life member
   
  When I agree to the rules and continue
   And I expect to see the Senior Life member full year fee
  
  When I enter a transaction number and click next
  Then I expect to see the membership renewal complete screen


@StudentMember
Scenario: As a student member I should be able to renew my membership
 Given I was previously a member
   And it is within the full year membership period
   
  When I navigate to the membership renewal screen
  
  Then I expect that my membership type is selected
   And I expect to see my student number
   
  When I agree to the rules and continue
   And I expect to see the Student member full year fee
  
  When I enter a transaction number and click next
  Then I expect to see the membership renewal complete screen


@PensionerMember
Scenario: As a pensioner member I should be able to renew my membership
 Given I was previously a member
   And it is within the full year membership period
   
  When I navigate to the membership renewal screen
  
  Then I expect that my membership type is selected
   And I expect to see my pensioner number
   
  When I agree to the rules and continue
   And I expect to see the Pensioner member full year fee
  
  When I enter a transaction number and click next
  Then I expect to see the membership renewal complete screen


@JuniorMember
Scenario: As a junior member I should be able to renew my membership
 Given I was previously a member
   And it is within the full year membership period
   
  When I navigate to the membership renewal screen
  
  Then I expect that my membership type is selected
   
  When I agree to the rules and continue
   And I expect to see the Junior member full year fee
  
  When I enter a transaction number and click next
  Then I expect to see the membership renewal complete screen


@NonFinancialMember
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

Scenario: As a senior member I can renew my membership as any of the other membership types

@NonFinancialMember
Scenario: As a member I can finalise my membership and then go back to the start of the process
 Given I was previously a member
   And it is within the full year membership period
   
  When I navigate to the membership renewal screen
   And I agree to the rules and continue
   And I enter a transaction number and click next
   
  Then I expect to see the membership renewal complete screen
   And I expect to see the link back to the fees

  When I click the link back to the fees
   
  Then I expect to see the Senior full member fee
   And I expect to not see the membership renewal complete screen
   
  When I click the link back to the membership renewal selection
  
  Then I expect to be shown the full financial year
   And I expect to see my address
