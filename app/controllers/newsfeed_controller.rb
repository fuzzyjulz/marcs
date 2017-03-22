class NewsfeedController < ApplicationController
  def index
    @news_list = Rails.cache.fetch("news", expires_in: 10.minutes) do
      getNews
    end
    
    render layout: nil
  end
  
  def getNews
    FacebookFeedItem.last(8)
  end
end
