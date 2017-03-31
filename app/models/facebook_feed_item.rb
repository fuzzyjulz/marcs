class FacebookFeedItem
  attr_accessor :message, :photo, :likesNum, :linkToPost, :createdDate, :logo, :author
  attr_accessor :event
  
  def self.last(num)
    facebook = FacebookFeed.new
    feed = facebook.feed
    
    outputFeedList = []
    feed.first(num).each do |feed_item|
      outputFeedList.push(FacebookFeedItem.new(feed_item, facebook, logo))
    end
    outputFeedList
  end
  
  def initialize(feed_item = nil, facebook = nil)
    unless feed_item.nil? or facebook.nil? or logo.nil?
      @logo = avatar(facebook)
      @message = [feed_item['message'],feed_item['description'],feed_item['story']].delete_if {|v| v.nil?}.first
      @photo = feed_item['picture'].gsub(/https:/,'http:') unless feed_item['picture'].nil?
      @linkToPost = "https://www.facebook.com/#{feed_item['id']}"
      @likesNum = feed_item['likes']['data'].length unless feed_item['likes'].nil?
      @createdDate = DateTime.iso8601(feed_item['created_time']) unless feed_item['created_time'].nil?
      @author = feed_item['from']['name']
      @event = FacebookFeedEvent.new(feed_item, facebook) if feed_item['type'] == "event"
    end
  end
  
  def avatar(facebook)
    Rails.cache.fetch("facebook_avatar", expires_in: 10.minutes, force: Rails.env.test?) do
      facebook.picture["picture"]["data"]["url"]
    end
  end
end
