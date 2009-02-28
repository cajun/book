Given /^a new (\w+)$/ do |model_name|
  instance_variable_set( "@#{model_name.downcase}", eval( model_name ).new )
end

Given /^a valid (\w+)$/ do |instance_var|
  instance_variable_get( "@#{instance_var}" ).valid?.should == true
end

Given /^the (\w+)'s (\w+) is set to '(.+)'$/ do |instance_var, field, value|
  instance_variable_get( "@#{instance_var}" ).send( "#{field}=".to_sym, value )
end

Given /^the (\w+)'s (\w+) is set to nil$/ do |instance_var, field|
  instance_variable_get( "@#{instance_var}" ).send( "#{field}=".to_sym, nil )
end

Given /^(\w+) will not be valid$/ do |instance_var|
  instance_variable_get( "@#{instance_var}" ).valid?.should == false
end

