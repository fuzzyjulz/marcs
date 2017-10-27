Feature: A committee member should be able to confirm renewals for the financial year

@Committee
Scenario: As a Committee member I can mark members for renewal
 Given I have a member who has completed their renewal
  When I navigate to the renewals screen
  Then I expect to see the confirm renewals screen
   And I expect to see the member who has completed their renewal
   And I expect to see the member has not been marked as paid
  When I set the payment date and mark as paid
  Then I expect to see the member has been marked as paid

@Member
Scenario: As a standard member I can't see or visit the renewal screen
 Given I have a member who has completed their renewal
  When I visit the renewals screen
  Then I expect to not see the confirm renewals screen
  Then I expect to not see the member who has completed their renewal

Scenario: Once the next financial year starts the renewal screen no longer shows the previous years renewals

