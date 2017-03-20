class GooglePhotoAlbum
  attr_reader :album_group, :title, :last_modified, :url
  
  def initialize(dir)
    @album_group = dir.title.sub(/-.*$/,"").rstrip
    @dir = dir
    
    @last_modified = dir.modified_time
    @title = dir.title
    @url = dir.web_view_link
  end
  
  def photos
    photos = []
    @dir.files.each do |photo|
      if photo.resource_type != "folder"
        photos << GooglePhoto.new(photo)
      end
    end
    photos
  end
  
  def self.all
    album_lists = []

    connection = GoogleConnection.new
    photos_dir = connection.get_photos_dirs
    
    photos_dir.each do |dir|
      album_lists << GooglePhotoAlbum.new(dir)
    end
    album_lists
  end
  
  def self.url(url)
    connection = GoogleConnection.new
    GooglePhotoAlbum.new(connection.get_by_url(url))
  end
end
