
When(/^I was previously a member$/) do
  
end

Given(/^it is within the full year membership period$/) do
  travel_to Time.new(2017, 7, 1, 01, 04, 44)
end

Given(/^it is within the half year membership period$/) do
  travel_to Time.new(2018, 2, 1, 01, 04, 44)
end

When(/^I navigate to the membership renewal screen$/) do
  MemberPage.new.open
  find(".renewMembership").click
end

When(/^I agree to the rules and continue$/) do
  check('membership_year_club_rules_accepted')
  click_on("Next")
end

When(/^I enter a transaction number and click next$/) do
  fill_in "membership_year_payment_authorised_number", with: "TransNumber"
  click_on("Next")
end

Then(/^I expect to( not)? be shown the full financial year$/) do |notIn|
  assert notIn.present? ^ has_text?("2017-2018 Full Year")
end

Then(/^I expect to( not)? be shown the half financial year$/) do |notIn|
  assert notIn.present? ^ has_text?("2017-2018 Half Year")
end

Then(/^I expect to( not)? see my address$/) do |notIn|
  assert notIn.present? ^ can_see_address?(@member)
end

Then(/^I expect that my membership type is( not)? selected$/) do |notIn|
  puts @member.membership_type
  assert notIn.present? ^ find('input[name="membership_year[membership_type]"][checked]')[:id].ends_with?(@member.membership_type.to_s)
end

Then(/^I expect that I am( not)? shown as an affiliate member$/) do |notIn|
  assert notIn.present? ^ find_all('input[id="membership_year_affiliate_true"][checked]').present?
end

Then(/^I expect that I am( not)? shown as a life member$/) do |notIn|
  assert notIn.present? ^ find_all(".LifeMembership").present?
end

Then(/^I expect to( not)? see my affiliated club name$/) do |notIn|
  assert notIn.present? ^ (find('input[id="membership_year_affiliated_club"]')[:value] == "My Affiliated Club")
end

Then(/^I expect to( not)? see my student number$/) do |notIn|
  assert notIn.present? ^ (find('input[id="membership_year_student_number"]')[:value] == "SN123456")
end

Then(/^I expect to( not)? see my pensioner number$/) do |notIn|
  assert notIn.present? ^ (find('input[id="membership_year_pensioner_number"]')[:value] == "PN123456")
end

Then(/^I expect to( not)? see the half year membership notice$/) do |notIn|
  assert notIn.present? ^ find_all('.halfYearNotice').present?
end

Then(/^I expect to( not)? see the Senior full member fee$/) do |notIn|
  assert notIn.present? ^ has_text?("\$205.00")
end

Then(/^I expect to( not)? see the Senior full member half year fee$/) do |notIn|
  assert notIn.present? ^ has_text?("\$102.50")
end

Then(/^I expect to( not)? see the Senior Affiliate member full year fee$/) do |notIn|
  assert notIn.present? ^ has_text?("\$91.00")
end

Then(/^I expect to( not)? see the Senior Life member full year fee$/) do |notIn|
  assert notIn.present? ^ has_text?("\$114.00")
end

Then(/^I expect to( not)? see the Student member full year fee$/) do |notIn|
  assert notIn.present? ^ has_text?("\$144.00")
end

Then(/^I expect to( not)? see the Pensioner member full year fee$/) do |notIn|
  assert notIn.present? ^ has_text?("\$159.50")
end

Then(/^I expect to( not)? see the Junior member full year fee$/) do |notIn|
  assert notIn.present? ^ has_text?("\$57.00")
end

Then(/^I expect to( not)? see the membership renewal complete screen$/) do |notIn|
  assert notIn.present? ^ find_all(".membershipRenewalComplete").present?
end

Then(/^I expect to( not)? see the link back to the fees$/) do |notIn|
  assert notIn.present? ^ find_all('.backToFees').present?
end

def can_see_address?(member)
  has_text? member.street and
  has_text? member.suburb and
  has_text? member.postcode
end
