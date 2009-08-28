# ================================================
# = Set of routes that will be used for the chef =
# ================================================
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
get "/chef/new" do
  @chef = Chef.new
  haml( "chef/new".to_sym )
end

# edit
get "/chef/edit/:id" do |id|
  @chef = Chef.get( id )
  haml( :"chef/edit" )
end

# show
get "/chef/:id" do |id|
  @chef = Chef.get( id )
  haml( :"chef/show" )
end


post "/chef/update/:id" do |id|
  @chef = Chef.get( id )
  # Thses params have to be assigned by hand
  pass = params['chef'].delete( 'password' )
  confirm_pass = params['chef'].delete( 'confirm_password' )

  unless( pass.blank? )
    @chef.password = pass 
    @chef.password_confirmation = confirm_pass
  end
  
  if( @chef.update_attributes( params['chef'] ) )
    haml( :"chef/show".to_sym )
  else
    flash['error'] = 'Sorry I could not update the chef.'
    haml( :"chef/edit" )
  end 
end