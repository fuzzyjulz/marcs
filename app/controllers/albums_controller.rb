class AlbumsController < ApplicationController
  def index
    Rails.cache.fetch("latest_photo_refresh",expires_in: 1.hours) do
      begin
        refreshAlbums unless Rails.env.test?
      rescue Faraday::ConnectionFailed
        #don't check again, as it probably won't work.
        logger.info "### Couldn't refresh the album, so just ignore until the next run time"
      end
      Time.now
    end
    
    @album_groups = Album.distinct.order(album_group: :desc).pluck(:album_group)
  end
  
  def show
    @albums = Album.where(album_group: request[:id]).order(title: :desc)
    @album_group = @albums.first.album_group
  end
  
  def refresh
    album = Album.find(request[:album_id])
    authorize! :refresh_album, album
    
    album.update!(last_modified: nil) if authorize! :refresh_album, album
    
    redirect_to(album_path(album.album_group))
  end
  def destroy
    album = Album.find(request[:id])
    authorize! :delete_album, album

    album.destroy!

    redirect_to(album_path(album.album_group))
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
