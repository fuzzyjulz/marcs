class FacebookFeed
  @@accessToken = nil

  def last(num)
    outputFeedList = []
    feed(num).first(num).each do |feed_item|
      outputFeedList.push(create_feed_item(feed_item)) unless feed_item.nil?
    end
    outputFeedList
  end

  private
  def picture(objectId = 'MarcsFlyingClub')
    graph_connection.get_object(objectId,{fields: 'picture'})
  end

  def feed(limit)
  graph_connection.get_connections("MarcsFlyingClub", "feed",\
    {limit: limit, fields: 'message,description,story,picture,likes,created_time,from,admin_creator,type,object_id'})
  end
  
  def event(objectId)
    graph_connection.get_object(objectId)
  end
  
  def create_feed_item(feed_item)
    item = FeedItem.new
    helper = FacebookFeedItemFacade.new(feed_item)
    
    item.logo = avatar
    item.message = helper.message
    item.photo = helper.photo
    item.linkToPost = helper.link_to_post
    item.likesNum = helper.likes
    item.createdDate = helper.created_date
    item.author = helper.author
    item.event = create_feed_event(helper.event_id) unless helper.event_id.nil?
    item
  end
  
  def create_feed_event(event_object_id)
    fb_event = FacebookFeedEventFacade.new(event(event_object_id))
    new_event = FeedEvent.new
    
    new_event.start_time = fb_event.start_time
    new_event.location = fb_event.location
    new_event
  end
  
  def avatar
    Rails.cache.fetch("facebook_avatar", expires_in: 10.minutes, force: Rails.env.test?) do
      picture["picture"]["data"]["url"]
    end
  end
  
  def graph_connection
    @graph = nil
    Koala.config.api_version = "v2.8"
    unless @@accessToken.nil?
      begin
        @graph = Koala::Facebook::API.new(@@accessToken)
      rescue
        @graph = nil
      end
    end
    if @graph.nil?
      koauth = Koala::Facebook::OAuth.new(ApplicationHelper::FACEBOOK_CLIENT_ID, ApplicationHelper::FACEBOOK_SECRET)
      @@accessToken = koauth.get_app_access_token
      @graph = Koala::Facebook::API.new(@@accessToken)
    end
    @graph
  end
end
