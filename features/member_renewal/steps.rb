
When(/^I was previously a member$/) do
  
end

Given(/^it is within the full year membership period$/) do
  travel_to Time.new(2017, 7, 1, 01, 04, 44)
end

When(/^I navigate to the membership renewal screen$/) do
  MemberPage.new.open
  find(".renewMembership").click
end

Then(/^I expect to( not)? be shown the full financial year$/) do |notIn|
  assert notIn.present? ^ has_text?("2017-2018 Full Year")
end

Then(/^I expect to( not)? see my address$/) do |notIn|
  assert notIn.present? ^ can_see_address?(@member)
end

Then(/^I expect that my membership type is( not)? selected$/) do |notIn|
  assert notIn.present? ^ find('input[name="membership_year[membership_type]"][checked]')[:id].ends_with?("senior")
end

When(/^I agree to the rules and continue$/) do
  check('membership_year_club_rules_accepted')
  click_on("Next")
end

When(/^I expect to( not)? see the half year membership notice$/) do |notIn|
  assert notIn.present? ^ find_all('.halfYearNotice').present?
end

When(/^I expect to see the appropriate fees$/) do
  has_text?("\$205.00")
end

When(/^I enter a transaction number and click next$/) do
  fill_in "membership_year_payment_authorised_number", with: "TransNumber"
  click_on("Next")
end

When(/^I expect to see the membership renewal complete screen$/) do
  find_all(".membershipRenewalComplete").present?
end

def can_see_address?(member)
  has_text? member.street and
  has_text? member.suburb and
  has_text? member.postcode
end
