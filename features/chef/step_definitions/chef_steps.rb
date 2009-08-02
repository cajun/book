Given /^the chef's is authorized by '(.+)' and '(.+)'$/ do |name, password|
  assert( Chef.authenticate( name, password ) )
end

Given /^the chef's is not authorized by '(.+)' and '(.+)'$/ do |name, password|
  assert_nil( Chef.authenticate( name, password ) )
end

