module Result
  include DataMapper::Resource
  is :remixable
  
  property :id, Serial
  property :body, Text
  property :rank, Integer
  property :created_at, DateTime
end