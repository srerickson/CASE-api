class CreateFieldValues < ActiveRecord::Migration
  def self.up
    create_table :field_values do |t|
      t.string  :type, default: "TextValue"
      t.integer :field_definition_id, null: false
      t.integer :case_id,             null: false 
      t.json    :value
      t.integer :user_id
      t.timestamps 
    end
  end

  def self.down
    drop_table :field_values
  end
end
