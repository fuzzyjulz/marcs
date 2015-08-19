class NewsfeedController < ApplicationController
  def view
    @newsList = getNews
    render layout: nil
  end
  
  def getNews
    FacebookFeedItem.last(8)
  end
end
