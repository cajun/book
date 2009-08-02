# ==================
# = Going to pages =
# ==================
Given /^you (\w+) to '(.+)'$/ do |action, page|
  @params ||= {}
  visit page, action.to_sym, @params
end  

Given /^you post to '(.+)' and create a new (\w+)$/ do |page, klass|
  klass = klass.constantize
  count = klass.all.size
  Given "you post to '#{page}'"
  assert( count + 1, klass.all.size )
end

# =============================
# = Setting params and fields =
# =============================
Given /^you set the parameter (\w+) to '(.+)'$/ do |param, value|
  @params ||= {}
  @params[param] = value
end

Given /^you fill in (.+) with '(.+)'$/ do |field,value|
  fill_in field, :with => value
end

# =========================
# = Action clicking stuff =
# =========================
Given /^you click the button '(.+)'$/ do |button_name|
  click_button( button_name )
end