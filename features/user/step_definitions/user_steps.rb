Given /^the password will be encrypted and have a length of (\d+)$/ do |length|
  @user.password.length.should == length.to_i
end

