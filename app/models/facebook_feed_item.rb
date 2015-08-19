class FacebookFeedItem
  attr_accessor :message, :photo, :likesNum, :linkToPost, :createdDate, :logo, :author
  attr_accessor :event

  @@accessToken = nil
  
  def self.last(num)
    graph = getGraphConnection
    logo = graph.get_object('MarcsFlyingClub',{fields: 'picture'})["picture"]["data"]["url"]
    feed = graph.get_connections("MarcsFlyingClub", "feed")
    
    outputFeedList = []
    feed.first(num).each do |feed|
      outputFeedList.push(FacebookFeedItem.new(feed, graph))
    end
    outputFeedList
  end
  
  def initialize(feed = nil, graph = nil)
    unless feed.nil? or graph.nil?
      map_feed_item(feed, graph)
    end
  end
  
  def map_feed_item(feed, graph)
    @message = [feed['message'],feed['description'],feed['story']].delete_if {|v| v.nil?}.first
    @photo = feed['picture'].gsub(/https:/,'http:') unless feed['picture'].nil?
    @linkToPost = feed['link']
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
