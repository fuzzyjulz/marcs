class AlbumsController < ApplicationController
  @@latest_photo_update = nil
  
  def index
    if @@latest_photo_update.nil? or @@latest_photo_update < Time.now - 1.hour
      begin
        refreshAlbums
      rescue Faraday::ConnectionFailed
        #don't check again, as it probably won't work.
        logger.info "### Couldn't refresh the album, so just ignore until the next run time"
      end
      @@latest_photo_update = Time.now
    end
    
    @album_groups = Album.uniq.order(album_group: :desc).pluck(:album_group)
  end
  
  def show
    @albums = Album.where(album_group: request[:id])
    @album_group = @albums.first.album_group
  end

  private
  
  def refreshAlbums
    GooglePhotoAlbum::all.each do |album|
      local_album = Album.where(title: album.title).first
      if local_album.nil?
        Album.new(title: album.title, album_group: album.album_group, url: album.url).save!
      else
        unless local_album.last_modified.nil? or local_album.last_modified == album.last_modified
          local_album.update(last_modified: nil) #Mark it to refresh
        end
      end
    end
  end
end