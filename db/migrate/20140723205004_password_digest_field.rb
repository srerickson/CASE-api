class PasswordDigestField < ActiveRecord::Migration
  def self.up
    add_column    :users, :password_digest, :string
    remove_column :users, :password_hash
  end

  def self.down
    add_column    :users, :password_hash, :string
    remove_column :users, :password_digest
  end
end
