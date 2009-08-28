# 
#  has_chef.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-04-06.
#  Copyright 2009 Cajun Country. All rights reserved.
# 
module HasChef
  
  module InstanceMethods
    def chef=( chef )
      if Chef === chef
        self["chef_id"] = chef.id
      end
    end

    def chef
      Chef.get( self["chef_id"] ) if self["chef_id"]
    end
    
  end
  
  def self.included(receiver)
    
    receiver.send :view_by, :chef_id
    receiver.send :include, InstanceMethods
  end
end