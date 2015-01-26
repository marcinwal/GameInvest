
class Asset

  include DataMapper::Resource

  has n, :trades, :through => Resource

  property :id, Serial
  property :name, String
  property :description, String

end
