class NewsfeedController < ApplicationController
  @@accessToken = nil
  
  def view
    @newsList = getNews
    render layout: nil
  end
  
  def getNews
    graph = getGraphConnection
    logo = graph.get_object('MarcsFlyingClub',{fields: 'picture'})["picture"]["data"]["url"]
    feed = graph.get_connections("MarcsFlyingClub", "feed")
    
    outputFeedList = []
    feed.first(8).each do |feed|
      feedItem = FeedItem.new
      feedItem.message = [feed['message'],feed['description'],feed['story']].delete_if {|v| v.nil?}.first
      feedItem.photo = feed['picture'].gsub(/https:/,'http:') unless feed['picture'].nil?
      feedItem.linkToPost = feed['link']
      feedItem.likesNum = feed['likes']['data'].length unless feed['likes'].nil?
      feedItem.createdDate = DateTime.iso8601(feed['created_time']) unless feed['created_time'].nil?
      feedItem.logo = logo
      feedItem.author = feed['from']['name']
      if feed['type'] == "event"
        objectId = feed['object_id']
        event = graph.get_object(objectId)
        feedItem.event = FeedEvent.new
        feedItem.event.startTime = DateTime.iso8601(event["start_time"])
        feedItem.event.location = event["location"]
        #binding.pry
      end
      outputFeedList.push(feedItem)
    end
    outputFeedList
  end
  
  private
  def getGraphConnection
    graph = nil
    unless @@accessToken.nil?
      begin
        graph = Koala::Facebook::API.new(@@accessToken)
      rescue
        graph = nil
      end
    end
    if graph.nil?
      koauth = Koala::Facebook::OAuth.new(facebook_client_id, facebook_secret)
      @@accessToken = koauth.get_app_access_token
      graph = Koala::Facebook::API.new(@@accessToken)
    end
    graph
  end
  
  class FeedItem
      attr_accessor :message, :photo, :likesNum, :linkToPost, :createdDate, :logo, :author
      attr_accessor :event
  end
  class FeedEvent
      attr_accessor :location, :startTime
  end
end
