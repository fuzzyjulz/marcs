When(/^I navigate to the member profile screen$/) do
  MemberPage.new.open
end

When(/^I update my profile details$/) do
  find(".updateProfile").click
  member = Members::UPDATED_MEMBER
  fill_in "user_first_name", with: member.first_name
  fill_in "user_last_name", with: member.last_name
  fill_in "user_email", with: member.email
  fill_in "user_street", with: member.street
  fill_in "user_city", with: member.suburb
  fill_in "user_postcode", with: member.postcode
  find(".updateMyDetails").click
end

Then(/^I expect to see that I am( not)? financial$/) do |notIn|
  assert notIn.present? ^ (page.find_all(".paidMembership").present? || page.find_all(".unconfirmedPaidMembership").present?)
end

Then(/^I expect to( not)? see my profile details$/) do |notIn|
  assert notIn.present? ^ can_see?(@member)
end

Then(/^I expect to( not)? see my updated profile details$/) do |notIn|
  assert notIn.present? ^ can_see?(Members::UPDATED_MEMBER)
end

def on_page?
  page.find_all("#memberDetails").present?
end

def can_see?(member)
  on_page? and \
  page.find(".memberName").has_text? member.first_name and
  page.find(".memberName").has_text? member.last_name and
  page.find(".email").has_text? member.email and
  page.find(".addressStreet").has_text? member.street and
  page.find(".addressCity").has_text? member.suburb and
  page.find(".addressPostcode").has_text? member.postcode
end