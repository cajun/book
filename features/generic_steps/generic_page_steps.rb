# ==================
# = Going to pages =
# ==================
Given /^you (\w+) to '(.+)'$/ do |action, page|
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
Given /^you set the parameter (.+) to '(.+)'$/ do |param, value|
  keys = param.split( '[' ).map{ |str| str.sub(']', '')}
  # Create a hash to hold the params.
  # convert model[field][array_index][field] into 
  # { model => { field => { array_index => {field => {}}}}}
  @params ||= Hash.new do |hash,key|
    tmp = {}.merge(hash)
    key.split( '[' ).inject( tmp ) do |h,k|
      h[k.sub(']','')] ||={}
    end
    hash.merge!( tmp )
  end
  
  # Init the hash
  @params[param]
  # Fill the value
  keys[0,keys.length-1].inject( @params ){|h,s| h[s] }[keys.last] = value
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