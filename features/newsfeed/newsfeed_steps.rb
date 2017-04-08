When(/^navigate to the newsfeed$/) do
  HomePage.new.open
end

Then(/^I expect to( not)? see the newsfeed$/) do |notIn|
  assert notIn.present? ^ page.find(".newsfeed").present?
end

Then(/^I expect to( not)? see the newsfeed items$/) do |notIn|
  assert notIn.present? ^ (page.find_all(".newsfeed .newsfeedView").size == 8)
  unless (notIn.present?)
    first_item = page.find_all(".newsfeed .newsfeedView").first
    first_item.find(".author").has_text? 'MARCS Flying Club'
    first_item.find(".time").has_text? '11-Mar-2017'
    first_item.find(".panel-body").has_text? "Sorry guys ... I'll be 'Absent Without Official Leave' for a week or so!"
    first_item.find(".panel-body").has_text? "Happy flying - Andrew Downey"
    assert_equal first_item.find(".panel-body .photo")[:src], 'http://scontent.xx.fbcdn.net/v/t1.0-1/c24.0.130.130/p130x130/17103236_257598854692256_4185990256169345708_n.jpg?oh=e90a18ee11c44aa9f34730dd38a4614a&oe=595BD915'
    first_item.find(".panel-footer").has_text? '2'
    assert_equal first_item.find(".panel-footer")[:href], 'https://www.facebook.com/240686749284785_1400625709957544'
  end
end
