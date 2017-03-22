When(/^I open the website$/) do
  visit(root_path)
end

When(/^I expect to( not)? see the home screen$/) do |notOn|
  assert(notOn.present? ^ page.find(".homeScreen").present?)
end

