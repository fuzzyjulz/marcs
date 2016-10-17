require 'open-uri'
class PhotosController < ApplicationController
  def index
    album = Album.find_by_id(request[:album_id])
    if (album.last_modified.nil?)
      refresh_album(album)
    end
    @album = album
    render layout: nil
  end
  
  def refresh_album(album)
    google_album = GooglePhotoAlbum.url(album.url)
    
    google_album.photos.each do |google_photo|
      next unless google_photo.mime_type == "image/jpeg"
      
      photo = album.photos.where(google_id: google_photo.google_id).first
      if photo.nil?
        photo = Photo.new(google_photo.instance_values)
        photo.album = album
        photo.save!
      else
        photo.update!(google_photo.instance_values)
      end
      
      unless google_photo.thumbnail_url.nil?
        photo.update_attribute(:thumbnail, open(google_photo.thumbnail_url))
      end
    end
    
    album.update!(last_modified: google_album.last_modified)
  end

end
