# 
#  chef.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-03-27.
#  Copyright 2009 Cajun Country. All rights reserved.
# 
class Chef < Couch
  attr_accessor :casted_by

  property :first_name
  property :last_name
  
  view_by :last_name
  view_by :first_name

  # Pull All the recipes via the chef
  def recipes
    Recipe.by_chef_id :key => self.id
  end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def to_s
    name
  end
end