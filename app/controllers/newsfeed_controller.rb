class NewsfeedController < ApplicationController
  def index
    @news_list = Rails.cache.fetch("news", expires_in: 10.minutes, force: Rails.env.test?) do
      getNews
    end
    
    render layout: nil
  end
  
  def getNews
    FeedItem.last(8)
  end
end
