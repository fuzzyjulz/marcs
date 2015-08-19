class FacebookFeedEvent
  attr_accessor :location, :startTime
  
  def initialize(feed = nil, graph = nil)
    unless feed.nil? or graph.nil?
      map_feed_item(feed, graph)
    end
  end

  def map_feed_item(feed, graph)
    objectId = feed['object_id']
    event = graph.get_object(objectId)
    @startTime = DateTime.iso8601(event["start_time"])
    @location = event["location"]
    self
  end
end
