module Tokens
  module ClassMethods
    
  end
  
  module InstanceMethods
    
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    
    receiver.send :property, :persistence_token
    receiver.send :property, :single_access_token
    receiver.send :property, :perishable_token
    
    receiver.send :include, InstanceMethods
  end
end