When(/^I navigate to the trainer details$/) do
  MemberPage.new.open
  click_on("Trainers") if find_all(".membersTrainers").present?
end

Then(/^I expect to( not)? see the (plane|heli) trainer details$/) do |notOn, plane_heli|
  assert(notOn.present? ^ page.find_all(get_trainer_section(plane_heli)).present?)
end

Then(/^I expect to( not)? see all (plane|heli) trainer members$/) do |notOn, plane_heli|
  puts get_trainers(plane_heli)
  assert(notOn.present? ^ (get_trainers(plane_heli) == get_expected_trainers(plane_heli)))
end

def get_trainer_section(plane_heli)
  plane_heli == "plane" ? "#planeTrainers" : "#heliTrainers"
end

def get_expected_trainers(plane_heli)
  if (plane_heli == "plane")
    ["Test Member"]
  else
    ["Committee Representitive"]
  end
end

def get_trainers(plane_heli)
  page.find_all("#{get_trainer_section(plane_heli)} .memberName").map {|e| e.text}
end
