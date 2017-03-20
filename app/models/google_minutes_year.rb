class GoogleMinutesYear
  attr_reader :title, :view_url, :id
  
  def initialize(dir)
    @title = dir.title
    @id = dir.title.gsub(/ /,"_")
    @view_url = dir.web_view_link
    
    @dir = dir
  end
  
  def minutes
    minutes = []
    @dir.files.each do |minutes_dir|
      minutes << GoogleMinutes.new(minutes_dir)
    end
    minutes
  end
  
  def self.all()
    minutes_years = []

    connection = GoogleConnection.new
    minutes_dir = connection.get_minutes_dirs

    minutes_dir.each do |minutes_year|
      minutes_years << GoogleMinutesYear.new(minutes_year)
    end
    
    minutes_years
  end

  def self.url(url)
    connection = GoogleConnection.new
    GooglePhotoAlbum.new(connection.get_by_url(url))
  end
end
