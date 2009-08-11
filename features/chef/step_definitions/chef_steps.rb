Given /^the chef's is authorized by '(.+)' and '(.+)'$/ do |name, password|
  assert( Chef.authenticate( name, password ), "failed to login for #{name} and #{password}" )
end

Given /^the chef's is not authorized by '(.+)' and '(.+)'$/ do |name, password|
  assert_nil( Chef.authenticate( name, password ) )
end

Given /^a current Chef of '(.+)'$/ do |name|
  c = Chef.new( :login => name )
  c.save
  stub( Chef ).current { c }
end
