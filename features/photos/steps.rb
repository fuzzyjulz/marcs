When(/^I navigate to the photo albums screen$/) do
  HomePage.new.open
  click_on("Photos")
end

When(/^I click on the photo album$/) do
  visit(find_all('.photoPanel')[0][:href])
end

Then(/^I expect to( not)? see a list of all photo albums in order$/) do |notIn|
  assert(notIn.present? ^ find_all('.photoGallery').present?)
  assert(notIn.present? ^ (find_all('.photoPanel').size == 3))
  unless notIn.present?
    photos = find_all('.photoPanel')
    photos[0].find('.albumName').has_text? 'Current'
    photos[1].find('.albumName').has_text? '1910'
    photos[2].find('.albumName').has_text? '1900'
  end
end

Then(/^I expect to see a list of all photos in the album order of the album name$/) do
  assert(find_all('.photoGallery').present?)
  find_all('.album .panel-title')[0].has_text? 'January'
  find_all('.album .panel-title')[1].has_text? 'February'
  find_all('.album .panel-title')[2].has_text? 'March'
  find_all('.album .panel-title')[3].has_text? 'April'
end
