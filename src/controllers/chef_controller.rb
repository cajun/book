get %r{/chef/index.?(\w*)} do |extention|
  @chefs = Chef.all( :limit => 10 )
  
  case extention
  when "json"
    @chefs.to_json
  else
    haml( "chef/index".to_sym )
  end
end

# new
get %r{/chef/new} do
  haml( "chef/new".to_sym )
end

# show
get %r{/chef/(\w+).?(\w*)} do |id,extention|
  @chef = Chef.get( id )

  case extention
  when "json"
    @chef.to_json
  else
    haml( "chef/show".to_sym )
  end
end

# create
post %r{/chef/create.?(\w*)} do |extention|
  expire_cache( "/chef/index" )
  @chef = Chef.new( params["chef"] )
  
  if( @chef.save )
    redirect "/chef/#{@chef.id}.#{extention}"
  else
    case extention
    when "json"
      { :errors => @chef.errors.to_json, :status => :error, :message => "Faild to save" }.to_json
    else
      "chef/new".to_sym
    end
  end
end
