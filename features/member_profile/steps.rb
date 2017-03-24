When(/^I navigate to the member profile screen$/) do
  MemberPage.new.open
end

When(/^I update my profile details$/) do
  
end

Then(/^I expect to see that I am( not)? financial$/) do |notIn|
  pending
end

Then(/^I expect to( not)? see my profile details$/) do |notIn|
  assert notIn.present? ^ can_see?(@member)
end

Then(/^I expect to see my updated profile details$/) do
  pending
end

def on_page?
  page.find_all("#memberDetails").present?
end

def can_see?(member)
  on_page? and \
  page.find(".firstName").has_text? @member.first_name and
  page.find(".lastName").has_text? @member.last_name and
  page.find(".email").has_text? @member.email and
  page.find(".addressStreet").has_text? @member.street and
  page.find(".addressCity").has_text? @member.suburb and
  page.find(".addressPostcode").has_text? @member.postcode
end