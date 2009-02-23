class Recipe
  include DataMapper::Resource
  
  property :id,           Serial
  property :name,         String,   :nullable => false, :key => true
  property :instructions, Text,     :nullable => false
  property :photo,        String
  property :video,        String
  property :user_id,      Integer,  :nullable => false, :key => true
  property :created_at,   DateTime
  
  is_nested_set
  
  remix n, :results
  
  has n, :ingredient_for_recipes
  has n, :ingredient, :through => :ingredient_for_recipes
  belongs_to :user
  
end