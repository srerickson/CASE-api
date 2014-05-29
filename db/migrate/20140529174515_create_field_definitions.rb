class CreateFieldDefinitions < ActiveRecord::Migration
  def self.up
    create_table :field_definitions do |t|
      t.integer :field_set_id
      t.string  :name
      t.string  :param
      t.string  :type 
      t.text    :description
      t.integer :order, default: 0
      t.timestamps 
    end
  end

  def self.down
    drop_table :field_definitions
  end
end
