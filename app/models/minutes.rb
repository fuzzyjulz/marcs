class Minutes
  include ActiveModel::Model
  
  attr_accessor :title, :view_url, :type
  
  def initialize(google_minutes)
    @title = google_minutes.filename
    @view_url = google_minutes.view_url
    @type = google_minutes.type
  end
end
