class Ingredient
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :nullable => false, :key => true
  property :created_at, DateTime
  
  remix 1, :amount_unit
  remix n, :results
  
  has n, :ingredient_for_recipes
  has n, :recipes, :through => :ingredient_for_recipes
end