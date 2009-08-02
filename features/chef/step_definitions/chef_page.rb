Given /^you click the button '(.+)' and create a new Chef$/ do |button_name|
  count = Chef.all.size
  Given "you click the button '#{button_name}'"
  assert_equal( count + 1, Chef.all.size )
end
