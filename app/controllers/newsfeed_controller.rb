class NewsfeedController < ApplicationController
  @@latest_news_update = nil
  
  def index
    if @@latest_news_update.nil? or @@latest_news_update < Time.now - 10.minutes
      #cache it for 10 minutes
      @@latest_news = getNews
      @@latest_news_update = Time.now
    end
    @news_list = @@latest_news
    
    render layout: nil
  end
  
  def getNews
    FacebookFeedItem.last(8)
  end
end
