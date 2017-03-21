class MinutesYear 
  include ActiveModel::Model
  
  attr_accessor :title, :view_url, :id, :minutes

  def initialize(google_minutes_year)
    @title = google_minutes_year.title
    @view_url = google_minutes_year.view_url
    @id = google_minutes_year.id
  end
end
