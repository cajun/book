Given /^you click the button '(.+)' and create a new Chef$/ do |button_name|
  count = Chef.all.size
  Given "you click the button '#{button_name}'"
  Chef.all.size.should == count + 1
end
