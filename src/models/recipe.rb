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
  property :ingredients, :cast_as => [ 'Ingredient' ]
  property :results, :cast_as => [ 'Result' ]
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

  def initialize( args={} )
    self['results'] ||= []
    self['ingredients'] ||= []
    super( args )
  end
  
  def valid?
    !name.nil? && !instructions.nil?
  end
  
  save_callback :before, :save_commit
  
  def save_commit
    if commit?
      commit.save
    end
  end
  
  def commit?
    false
  end
end