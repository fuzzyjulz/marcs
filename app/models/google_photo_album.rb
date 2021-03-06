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
    @dir.files do |photo|
      if photo.resource_type != "folder"
        photos << GooglePhoto.new(photo) unless photo.trashed?
      end
    end
    photos
  end
  
  def self.all
    album_lists = []

    connection = GoogleConnection.new
    photos_dir = connection.get_photos_dirs
    
    photos_dir.each do |dir|
      album_lists << GooglePhotoAlbum.new(dir) unless dir.trashed?
    end
    album_lists
  end
  
  def self.url(url)
    connection = GoogleConnection.new
    photos_dir = connection.get_by_url(url)

    if photos_dir.trashed?
      nil
    else
      GooglePhotoAlbum.new(photos_dir)
    end
  end
end
