class FacebookFeedEventFacade
  def initialize(facebook_event = nil)
    @facebook_event = facebook_event
  end
  
  def startTime
    DateTime.iso8601(@facebook_event["start_time"])
  end

  def location
    @facebook_event["location"]
  end
end
