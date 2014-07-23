# require 'password_hash'

class User < ActiveRecord::Base

  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :email 

  has_secure_password

  def jwt_token() 
    self.attributes.select { |key| ["id", "email", "name","updated_at"].include? key }
  end


  # class method for validating credentials
  def self.validate(email,pass)
    if user = User.where(email: email).first
      user.try(:authenticate, pass)
    else
      false
    end
  end


end