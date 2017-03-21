class FacebookFeedItem
  attr_accessor :message, :photo, :likesNum, :linkToPost, :createdDate, :logo, :author
  attr_accessor :event

  @@accessToken = nil
  
  def self.last(num)
    graph = getGraphConnection
    logo = graph.get_object('MarcsFlyingClub',{fields: 'picture'})["picture"]["data"]["url"]
    feed = graph.get_connections("MarcsFlyingClub", "feed")
    
    outputFeedList = []
    feed.first(num).each do |feed_item|
      outputFeedList.push(FacebookFeedItem.new(feed_item, graph, logo))
    end
    outputFeedList
  end
  
  def initialize(feed = nil, graph = nil, logo = nil)
    unless feed.nil? or graph.nil? or logo.nil?
      map_feed_item(feed, graph, logo)
    end
  end
  
  def map_feed_item(feed, graph, logo)
    @message = [feed['message'],feed['description'],feed['story']].delete_if {|v| v.nil?}.first
    @photo = feed['picture'].gsub(/https:/,'http:') unless feed['picture'].nil?
    @linkToPost = "https://www.facebook.com/#{feed['id']}"
    @likesNum = feed['likes']['data'].length unless feed['likes'].nil?
    @createdDate = DateTime.iso8601(feed['created_time']) unless feed['created_time'].nil?
    @logo = logo
    @author = feed['from']['name']
    @event = FacebookFeedEvent.new(feed, graph) if feed['type'] == "event"
    self
  end
  
  private
  def self.getGraphConnection
    graph = nil
    unless @@accessToken.nil?
      begin
        graph = Koala::Facebook::API.new(@@accessToken)
      rescue
        graph = nil
      end
    end
    if graph.nil?
      koauth = Koala::Facebook::OAuth.new(ApplicationHelper::FACEBOOK_CLIENT_ID, ApplicationHelper::FACEBOOK_SECRET)
      @@accessToken = koauth.get_app_access_token
      graph = Koala::Facebook::API.new(@@accessToken)
    end
    graph
  end
end
