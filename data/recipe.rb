class Recipe
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :nullable => false, :key => true
  property :instructions, Text
  property :created_at, DateTime
  
  remix n, :results
  
end