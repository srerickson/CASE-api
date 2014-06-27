class AddCaseImageColumn < ActiveRecord::Migration
  def self.up
    add_column :cases, :image, :string
  end

  def self.down
    remove_column :cases, :image
  end
end
