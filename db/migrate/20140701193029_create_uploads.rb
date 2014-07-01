class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      t.string  :asset
      t.string  :content_type
      t.integer :file_size
      t.integer :height
      t.integer :width 
      t.integer :parent_id
      t.string  :parent_type
      t.integer :uploaded_by_id
      t.text    :caption
      t.timestamps
    end
  end

  def self.down
    drop_table :uploads
  end
end
