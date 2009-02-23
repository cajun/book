class User
  include DataMapper::Resource
  
  property :id,       Serial,       :nullable => false
  property :email,    String,       :nullable => false
  property :login,    String,       :nullable => false
  property :password, BCryptHash,   :nullable => false
  
end