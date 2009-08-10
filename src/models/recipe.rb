# 
#  recipe.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-03-27.
#  Copyright 2009 Cajun Country. All rights reserved.
# 
class Recipe < Couch
  include HasChef
  
  property :name
  property :instructions
  property :photo
  property :video
  property :state
  property :ingredients, :cast_as => [ 'Ingredient' ], :default => []
  property :results, :cast_as => [ 'Result' ], :default => []
  property :commit, :cast_as => "Commit"
  
  # ========================
  # = Setting up the views =
  # ========================
  view_by :name
  view_by :ingredients, :map => 
    "function(doc){
      if ((doc['couchrest-type'] == 'Recipe') && doc['ingredients']) {
        for( var ix in doc['ingredients'] ){
          emit( doc['ingredients'][ix].name,{recipe_id: doc._id, count: 1});  
        }
      }
    }
  ",
  :reduce => 
    "function( key,values,reduce){
      var count =0;
      var rec = new Array();
      var x;
      for( x in values ){
        count += values[x].count;
        rec[x] = values[x].recipe_id;
      }
      return { total: count, recipe_id: rec }
    }"
  
  # =============
  # = Callbacks =
  # =============
  save_callback :before, :save_commit
  save_callback :before, :can_edit?
  
  # ===============
  # = Validations =
  # ===============
  
  # Determine who is allowed to edit this recipe
  # The base rules will only allow the creator edit the recipe
  # 
  # @returns [Boolean] this is going to be a tuf one to figure out
  def can_edit?
    throw( :halt ) unless( (!Chef.current.nil? && Chef.current) == self.chef )
  end
  
  # Check to determine if this recipe is valid
  # Limited validations now for recipes
  #
  # @returns [Boolean] the succcessfullness of the save
  def valid?
    !name.nil? && !instructions.nil?
  end
  
  def commit?
    false
  end
  
  def save_commit
    if commit?
      commit.save
    end
  end
  
end