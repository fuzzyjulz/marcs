require 'webmock/cucumber'

Before do
  fixtures_folder = File.join(Rails.root, 'test', 'fixtures')
  
  
  stub_request(:post, "https://graph.facebook.com/v2.8/oauth/access_token").\
    to_return(:status => 200, :body => "##ACCESSTOKEN##", :headers => {})
  
  stub_request(:get, "http://graph.facebook.com/v2.8/MarcsFlyingClub/feed?fields=message,description,story,picture,likes,created_time,from,admin_creator,type,object_id&limit=8").\
    to_return(:status => 200, :body => File.read(File.join(fixtures_folder,"facebook_feed.json")), :headers => {})
  
  stub_request(:get, "http://graph.facebook.com/v2.8/MarcsFlyingClub?fields=picture").
    to_return(:status => 200, :body => File.read(File.join(fixtures_folder,"facebook_picture.json")), :headers => {})
end
