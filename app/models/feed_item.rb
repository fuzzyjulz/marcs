class FeedItem
  include ActiveModel::Model
  
  attr_accessor :message, :photo, :likesNum, :linkToPost, :createdDate, :logo, :author
  attr_accessor :event
  
  def self.last(num)
    facebook = FacebookFeed.new.last(num)
  end
end
