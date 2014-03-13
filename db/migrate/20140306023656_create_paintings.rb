class CreatePaintings < ActiveRecord::Migration
  def change
    create_table :paintings do |t|
      t.integer :gallery_id
      t.string :url
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
