class CreateSchemas < ActiveRecord::Migration
  def self.up
    create_table :schemas do |t|
      t.string  :name
      t.string  :param
      t.text    :description
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
  	drop_table :schemas
  end
end
