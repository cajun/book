require File.dirname(__FILE__) + "/../test_helper"

describe "What Users do" do
  extend MetaTests
  
  it 'should encrypt passwords' do
    u = User.new( :email => 'foo@bar.com', :login => 'cajun', :password => 'supar cool' )
    u.password.should.not.be.nil
    u.password.should not_equal( 'supar cool' )
  end
end