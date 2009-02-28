Given /^you click the button '(.+)' and create a new recipe$/ do |button_name|
  count = Recipe.count
  Given "you click the button '#{button_name}'"
  Recipe.count.should == count + 1
end
