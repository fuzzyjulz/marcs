When(/^I open the website$/) do
  visit(root_path)
end

Then(/^I expect to( not)? see the home screen$/) do |notOn|
  assert(notOn.present? ^ page.find(".homeScreen").present?)
end

When(/^the day is day after tomorrow$/) do
  puts "Setting date to #{Date.tomorrow+1}"
  travel_to Date.tomorrow+1
end

Given(/^it is within the full year membership period$/) do
  time = Time.new(2017, 7, 1, 01, 04, 44)
  puts "Setting date to #{time}"
  travel_to time
end

Given(/^it is at the end of the full year membership period$/) do
  time = Time.new(2018, 6, 30, 01, 04, 44)
  puts "Setting date to #{time}"
  travel_to time
end
Given(/^it is at the start of the next membership period$/) do
  time = Time.new(2018, 7, 1, 01, 04, 44)
  puts "Setting date to #{time}"
  travel_to time
end

Given(/^it is within the half year membership period$/) do
  time = Time.new(2018, 2, 1, 01, 04, 44)
  puts "Setting date to #{time}"
  travel_to time
end
