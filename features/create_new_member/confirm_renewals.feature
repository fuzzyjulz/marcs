Feature: A committee member can create a new member

@Committee
Scenario Outline: As a Committee member I can create a new member and that member can enroll themselves
 When I navigate to the create new member screen
  And I enter in the new member details
  And I create the new member
 Then I expect to see the new member details
 When I select <membership_type> and <affiliation> and create the membership
  And I expect to see the new <membership_type> <affiliation> fee

Examples:
 | membership_type | affiliation   |
 | senior          | affiliate     |
 | senior          | non affiliate |
 | pensioner       | affiliate     |
 | pensioner       | non affiliate |
 | junior          | affiliate     |
 | junior          | non affiliate |
 | student         | affiliate     |
 | student         | non affiliate |
