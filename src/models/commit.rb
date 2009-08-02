# 
#  commit.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-06-04.
#  Copyright 2009 Cajun Country. All rights reserved.
# 
class Commit < Couch
  property :root
  property :lft
  property :rht
  property :comment
  
  
  def root=( root_recipe )
    assign_id_to_property( root_recipe, 'root', Recipe )
  end
  
  def root
    Recipe.get( self["root"] ) if self["root"]
  end

  def lft=( left_recipe )
    assign_id_to_property left_recipe, 'lft', Recipe
  end
  
  def lft
    Recipe.get( self["lft"] ) if self["lft"]
  end

  def rht=( right_recipe )
    assign_id_to_property right_recipe, 'rht', Recipe 
  end
  
  def rht
    Recipe.get( self["rht"] ) if self["rht"]
  end
  
  def assign_id_to_property( value, attr, klass )
    self[attr] = klass === value ? value.id : value
  end
end