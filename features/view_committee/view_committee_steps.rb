When(/^I navigate to the committee details$/) do
  MemberPage.new.open
  click_on("Committee")
end

Then(/^I expect to( not)? see the committee details$/) do |notOn|
  assert(notOn.present? ^ page.find_all("#ClubCommittee").present?)
end

Then(/^I expect to( not)? see all committee members$/) do |notOn|
  puts get_committee_members
  assert(notOn.present? ^ (get_committee_members == ["Committee Representitive"]))
end

def get_committee_members
  page.find_all(".committeeMemberName").map {|e| e.text}
end
