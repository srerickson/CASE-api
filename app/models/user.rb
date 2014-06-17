require 'password_hash'

class User < ActiveRecord::Base

  validates_presence_of :name, :email, :password_hash
  validates_uniqueness_of :email 

  def password=(pass)
    self.password_hash = PasswordHash.createHash(pass)
  end

  def jwt_token() 
    self.attributes.select { |key| ["id", "email", "name",].include? key }
  end


  # class method for validating credentials
  def self.validate(email,pass)
    if user = User.where(email: email).first
      PasswordHash.validatePassword(pass, user.password_hash) ? user : false 
    else
      false
    end
  end


end