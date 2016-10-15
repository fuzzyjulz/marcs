class AddAlbums < ActiveRecord::Migration
  def change
    create_table (:albums) do |t|
      t.string :album_group, null: false
      t.string :title, null: false
      t.datetime :last_modified, null: true
      t.string :url, null: false
    end
  end
end
