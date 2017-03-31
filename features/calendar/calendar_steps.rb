When(/^I navigate to the calendar$/) do
  ENV["CLUB_CALENDAR"] = "test/fixtures/club.ics"
  ENV["COMMITTEE_CALENDAR"] = "test/fixtures/committee.ics"
  travel_to Time.new(2017, 1, 1, 01, 04, 44)
  HomePage.new.open
end

Then(/^I expect to( not)? see the calendar$/) do |notOn|
  assert(notOn.present? ^ page.find(".calendarView").present?)
end

Then(/^I expect to( not)? see the club events$/) do |notOn|
  assert(notOn.present? ^ (get_club_events == \
  ["25 Jan at 7:00PM Club Meeting","25 Feb at 9:00AM Working Bee(to be confirmed)"]))
end

Then(/^I expect to( not)? see the committee events$/) do |notOn|
  assert(notOn.present? ^ (get_committee_events == \
  ["16 Jan at 7:00PM Committee Meeting"]))
end

def get_club_events()
  page.find_all(".event.clubEvent").map {|e| e.text}
end

def get_committee_events()
  page.find_all(".event.committeeEvent").map {|e| e.text}
end
