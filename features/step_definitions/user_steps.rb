Given /^new user with email '(.*@.*)' and login '(\w+)'$/ do |email, login|
  @user = User.new( :email => email, :login =>login )
end


When /^the password is set to '(.*)'$/ do |password|
  @user.password = password
end

Then /^the password will be encrypted and have a length of (\d+)$/ do |length|
  @user.password.length.should == length.to_i
end

