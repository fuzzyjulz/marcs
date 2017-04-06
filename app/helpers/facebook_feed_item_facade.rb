class FacebookFeedItemFacade
  def initialize(facebook_item = nil)
    @facebook_item = facebook_item
  end
  
  def message
    [@facebook_item['message'],@facebook_item['description'],@facebook_item['story']].delete_if {|v| v.nil?}.first
  end

  def photo
    @facebook_item['picture'].gsub(/https:/,'http:') unless @facebook_item['picture'].nil?
  end
  
  def link_to_post
    "https://www.facebook.com/#{@facebook_item['id']}"
  end
  
  def likes
    @facebook_item['likes']['data'].length unless @facebook_item['likes'].nil?
  end
  
  def created_date
    DateTime.iso8601(@facebook_item['created_time']) unless @facebook_item['created_time'].nil?
  end
  
  def author
    @facebook_item['from']['name']
  end
  
  def event_id
    @facebook_item['object_id'] if @facebook_item['type'] == "event"
  end
end
