Given /^you click the button '(.+)' and create a new Recipe$/ do |button_name|
  count = Recipe.all.size
  Given "you click the button '#{button_name}'"
  assert_equal( count + 1, Recipe.all.size )
end
