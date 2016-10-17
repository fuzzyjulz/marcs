class AddThumbnailToPhoto < ActiveRecord::Migration
  def up
      add_attachment :photos, :thumbnail
    end
  
    def down
      remove_attachment :photos, :thumbnail
    end
end
