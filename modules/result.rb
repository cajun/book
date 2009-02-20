module Result
  include DataMapper::Resource
  is :remixable
  
  property :id, Integer, :key => true, :serial => true
  property :body, Text
  property :rank, :Integer
  property :created_at, DateTime
end