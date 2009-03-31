# ======================
# = Creating instances =
# ======================
Given /^a new (\w+)$/ do |model_name|
  instance_variable_set( "@#{model_name.downcase}", model_name.constantize.new )
end

# =====================
# = Setting variables =
# =====================
Given /^the (\w+)'s (\w+) is set to '(.+)'$/ do |instance_var, field, value|
  instance_variable_get( "@#{instance_var}" ).send( "#{field}=".to_sym, value )
end

Given /^the (\w+)'s (\w+) is set to @(\w+)$/ do |instance_var, field, other_instance_var|
  instance_variable_get( "@#{instance_var}" ).send( "#{field}=".to_sym, instance_variable_get( "@#{other_instance_var}" ) )
end

Given /^the (\w+)'s (\w+) is set to nil$/ do |instance_var, field|
  instance_variable_get( "@#{instance_var}" ).send( "#{field}=".to_sym, nil )
end

Given /the (\w+) is added to the (\w+)'s (\w+) (\d+) times/ do |item, model, collection, number_of_additions|
  number_of_additions = number_of_additions.to_i
  var_item = instance_variable_get( "@#{item}" )
  var_model = instance_variable_get( "@#{model}" )
  instance_variable_set( "@#{collection}_original_size", var_model.send( collection ).size )
  number_of_additions.times do
    Given "the #{item} is added to the #{model}'s #{collection}"
  end
end

Given /the (\w+) is added to the (\w+)'s (\w+)/ do |item, model, collection|
  var_item = instance_variable_get( "@#{item}" )
  var_model = instance_variable_get( "@#{model}" )
  var_model.send( collection ) << var_item
end

# ===============
# = Validations =
# ===============
Given /the (\w+)'s (\w+) will have (\d+) more/ do |model, collection, count|
  var_model = instance_variable_get( "@#{model}" )
  original_size = instance_variable_get( "@#{collection}_original_size" )
  (original_size + count.to_i ).should == var_model.send( collection ).size
end

Given /^a valid (\w+)$/ do |instance_var|
  instance_variable_get( "@#{instance_var}" ).valid?.should == true
end

Given /^(\w+) will not be valid$/ do |instance_var|
  instance_variable_get( "@#{instance_var}" ).valid?.should == false
end

Given /^the (\w+)'s (\w+) is equal to '(.+)'$/ do |instance_var, field, test|
  var_item = instance_variable_get( "@#{instance_var}" )
  var_item.send( field ).should == test
end

Given /^the (\w+)'s (\w+) is not equal to '(.+)'$/ do |instance_var, field, test|
  var_item = instance_variable_get( "@#{instance_var}" )
  var_item.send( field ).should_not equal test
end


# ==========
# = Saving =
# ==========
Given /^save the (\w+)$/ do |model|
  instance_variable_get( "@#{model}" ).save
end

Given /^the (\w+) is saved$/ do |model|
  Given "save the #{model}"
end

