require File.dirname(__FILE__) + "/../test_helper"

describe "How to create a recipe" do
  extend MetaTests
  
  it 'should have validations' do
    params = {
      'name' => 'supar cool',
      'instructions' => 'wow this is supar cool recipe'
    }
    post '/recipes/create', params
    should.be.ok
  end
end