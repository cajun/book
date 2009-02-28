Given /^you (\w+) to '(.+)'$/ do |action, page|
  @params ||= {}
  visit page, action.to_sym, @params
end  

Given /^you set the paramaters '(\w+)' and '(.+)'$/ do |name, instructions|
  @params = { :name => name, :instructions => instructions }
end

Given /^you fill in (.+) with '(.+)'$/ do |field,value|
  fill_in field, :with => value
end

Given /^you click the button '(.+)'$/ do |button_name|
  click_button( button_name )
end