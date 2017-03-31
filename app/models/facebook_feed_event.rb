class FacebookFeedEvent
  attr_accessor :location, :startTime
  
  def initialize(feed = nil, facebook = nil)
    unless feed.nil? or facebook.nil?
      event = facebook.event(feed['object_id'])
      @startTime = DateTime.iso8601(event["start_time"])
      @location = event["location"]
    end
  end

end
