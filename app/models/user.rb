require 'bcrypt'

class User

  include DataMapper::Resource

  has n, :trades, :through => Resource

  property :id, Serial
  property :email, String, :unique => true, :message => "Email is already in use"
  property :password_digest, Text
  property :password_token, Text
  property :password_token_timestamp, DateTime


end
