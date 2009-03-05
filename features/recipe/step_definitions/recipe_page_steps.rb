Given /^you click the button '(.+)' and create a new recipe$/ do |button_name|
  count = Recipe.all.size
  Given "you click the button '#{button_name}'"
  Recipe.all.size.should == count + 1
end
