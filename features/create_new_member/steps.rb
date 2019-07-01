
When(/^I navigate to the create new member screen$/) do
  MemberPage.new.open
  find(".createNewMember").click
end

When(/^I enter in the new member details$/) do
  fill_in("user_fai", with: "123456")
  fill_in("user_first_name", with: "Hey")
  fill_in("user_last_name", with: "ThatGuy")
end

When(/^I create the new member$/) do
  find(".updateMyDetails").click
end

Then(/^I expect to see the new member details$/) do
  assert has_text?("Hey ThatGuy")
end

When(/^I select (senior|pensioner|student|junior|spectator) and( non)? affiliate and create the membership$/) do |membership_type, non_affiliate|
  choose("membership_year_membership_type_#{membership_type}")
  if non_affiliate.present?
    choose("membership_year_affiliate_false")
  else
    choose("membership_year_affiliate_true")
    fill_in("membership_year_affiliated_club", with: "Another club")
  end
  if membership_type == "pensioner"
    fill_in("membership_year_pensioner_number", with: "1234Pension")
  end
  if membership_type == "student"
    fill_in("membership_year_student_number", with: "456Student")
  end
  click_on("submitButton")
end

When(/^I expect to see the new senior non affiliate fee$/) do
  assert has_text?("$245.00")
end

When(/^I expect to see the new senior affiliate fee$/) do
  assert has_text?("$131.00")
end

When(/^I expect to see the new pensioner affiliate fee$/) do
  assert has_text?("$85.50")
end

When(/^I expect to see the new pensioner non affiliate fee$/) do
  assert has_text?("$199.50")
end

When(/^I expect to see the new junior affiliate fee$/) do
  assert has_text?("$40.00")
end

When(/^I expect to see the new junior non affiliate fee$/) do
  assert has_text?("$97.00")
end

When(/^I expect to see the new student affiliate fee$/) do
  assert has_text?("$70.00")
end

When(/^I expect to see the new student non affiliate fee$/) do
  assert has_text?("$184.00")
end

When(/^I expect to see the new spectator affiliate fee$/) do
  assert has_text?("$131.00")
end

When(/^I expect to see the new spectator non affiliate fee$/) do
  assert has_text?("$131.00")
end
