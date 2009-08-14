
get '/login' do
  haml( :login )
end

post '/login' do
  @chef = Chef.authenticate( params[:login], params[:password] )
  if( @chef )
    # logged in 
    session[:chef_id] = @chef.id
    @chef.set_env_success( request )
  end
  haml( :index )
end

post '/logout' do
  session[:chef_id]
  haml( :index )
end  


