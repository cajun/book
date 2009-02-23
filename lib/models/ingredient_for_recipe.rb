class IngredientForRecipe
  include DataMapper::Resource
  
  property :id, Serial
  property :recipe_id, Integer
  property :ingredient_id, Integer
  
  remix n, :results
  remix 1, :amount_unit
  
  belongs_to :recipe
  belongs_to :ingredient
end