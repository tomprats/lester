class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.integer :cover_id
      t.integer :artist_id
      t.string :title
      t.string :description
      t.boolean :private, default: true
      t.datetime :published_at

      t.timestamps
    end
  end
end
