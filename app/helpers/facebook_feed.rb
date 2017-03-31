class FacebookFeed
  @@accessToken = nil

  def picture(objectId = 'MarcsFlyingClub')
    @graph.get_object(objectId,{fields: 'picture'})
  end

  def feed
    graph.get_connections("MarcsFlyingClub", "feed")
  end
  
  def event(objectId)
    graph.get_object(objectId)
  end
  
  def getGraphConnection
    @graph = nil
    unless @@accessToken.nil?
      begin
        @graph = Koala::Facebook::API.new(@@accessToken)
      rescue
        @graph = nil
      end
    end
    if @graph.nil?
      koauth = Koala::Facebook::OAuth.new(ApplicationHelper::FACEBOOK_CLIENT_ID, ApplicationHelper::FACEBOOK_SECRET)
      @@accessToken = koauth.get_app_access_token
      @graph = Koala::Facebook::API.new(@@accessToken)
    end
    @graph
  end
end
