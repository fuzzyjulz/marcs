class AddPhotos < ActiveRecord::Migration
  def change
    create_table (:photos) do |t|
      t.integer :album_id, null: false
      t.string :google_id, null: false
      t.string :photo_url, null: false
      t.string :filename, null: false
      t.string :thumbnail_url, null: true
      t.string :mime_type, null: false
      t.string :file_extension, null: false
      t.datetime :created_time, null: false
    end
    
    add_foreign_key :photos, :albums
  end
end
