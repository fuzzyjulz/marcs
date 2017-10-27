
When(/^I navigate to the renewals screen$/) do
  confirm_renewals.open
end

When(/^I visit the renewals screen$/) do
  confirm_renewals.visit_page
end

Then(/^I expect to( not)? see the confirm renewals screen$/) do |notIn|
  assert notIn.present? ^ find_all(".confimRenewals").present?
end

When(/^I set the payment date and mark as paid$/) do
  completed_member = Members::COMMITTEE_MEMBER
  confirm_renewals.set_paid(completed_member, "1/1/2017")
end

Then(/^I expect to( not)? see the member who has completed their renewal$/) do |notIn|
  completed_member = Members::COMMITTEE_MEMBER
  puts completed_member.name
  
  assert notIn.present? ^ (has_text?(completed_member.first_name) and 
    has_text?(completed_member.last_name))
end

Then(/^I expect to see the member has( not)? been marked as paid$/) do |notIn|
  completed_member = Members::COMMITTEE_MEMBER
  assert notIn.present? ^ (!confirm_renewals.payment_date_field(completed_member).present?)
end

def confirm_renewals
  ConfirmRenewalsPage.new
end
