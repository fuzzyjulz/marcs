When(/^I open the website$/) do
  visit(root_path)
end

Then(/^I expect to( not)? see the home screen$/) do |notOn|
  assert(notOn.present? ^ page.find(".homeScreen").present?)
end

When(/^the day is tomorrow$/) do
  travel_to Date.tomorrow
end
