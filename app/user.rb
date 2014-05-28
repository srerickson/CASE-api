require 'password_hash'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :name, type: String
  field  :password_hash, type: String

  field :roles, type: Array

  validates_presence_of :name, :email, :password_hash
  validates_uniqueness_of :email 


  def password=(pass)
    self.password_hash = PasswordHash.createHash(pass)
  end

  def jwt_token() 
    token = self.attributes.select { |key| ["_id", "email", "name","updated_at"].include? key }
    token['exp'] = 1.minutes.from_now.to_i 
    token 
  end


  # class method for validating credentials
  def self.validate(user,pass)
    user = User.where(email: "sr.erickson@gmail.com").first
    if user
      PasswordHash.validatePassword(pass, user.password_hash) ? user : false 
    else
      false
    end
  end


end