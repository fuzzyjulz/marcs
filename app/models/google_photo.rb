class GooglePhoto
  attr_reader :google_id, :photo_url, :filename, :thumbnail_url, :mime_type, :file_extension, :created_time
  
  def initialize(photo)
    @google_id = photo.id
    @photo_url = photo.web_content_link
    if photo.original_filename.nil?
      binding.pry
    end
    @filename = photo.original_filename.sub(/\..*$/,"")
    @thumbnail_url = photo.thumbnail_link
    @mime_type = photo.mime_type
    @file_extension = photo.file_extension
    @created_time = photo.created_time
  end
end
