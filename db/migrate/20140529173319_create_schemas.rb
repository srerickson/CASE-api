class CreateSchemas < ActiveRecord::Migration
  def self.up
    create_table :schemas do |t|
      t.string  :name
      t.string  :param
      t.text    :description
      t.integer	:field_set_ids, array: true, default: []
      t.integer :user_id
      t.timestamps
    end
    add_index  :schemas, :field_set_ids, using: 'gin'
  end

  def self.down
  	drop_table :schemas
  end
end
