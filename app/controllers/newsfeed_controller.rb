class NewsfeedController < ApplicationController
  @@latestNewsUpdate = nil
  
  def index
    if @@latestNewsUpdate.nil? or @@latestNewsUpdate < Time.now - 10.minutes
      #cache it for 10 minutes
      @@latestNews = getNews
      @@latestNewsUpdate = Time.now
    end
    @newsList = @@latestNews
    
    render layout: nil
  end
  
  def getNews
    FacebookFeedItem.last(8)
  end
end
