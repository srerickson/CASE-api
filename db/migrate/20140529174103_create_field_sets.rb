class CreateFieldSets < ActiveRecord::Migration
  def self.up
  	create_table :field_sets do |t|
      t.integer :schema_id
  		t.string  :name
      t.string  :param
      t.text    :description
      t.integer :order
      t.timestamps
  	end
  end

  def self.down
  	drop_table :field_sets
  end
end
