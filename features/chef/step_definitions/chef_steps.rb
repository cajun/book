Given /^the chef's is authorized by '(.+)' and '(.+)'$/ do |name, password|
  Chef.authenticate( name, password ).should_not == nil
end

Given /^the chef's is not authorized by '(.+)' and '(.+)'$/ do |name, password|
  Chef.authenticate( name, password ).should == nil
end

