class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    create_table :taggable do |t|
      t.integer :tag
      t.integer :tagged_id
      t.string  :tagged_type

      t.timestamps
    end
  end
end
